Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C93B079727A
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:02:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEci-0002gt-QK; Thu, 07 Sep 2023 09:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeEce-0002er-7i
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qeEcZ-00072M-Hb
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZkrrJNvVY+USbE6wiyJZt9AcIZY5MSlB4E/rDfxIrFw=;
 b=WmsMPTT9BJPRzg2ZgHskRUhVAsZ9Uk6dcz8ADJQfu9Y7I8efhFIZZ641COfu53S3PJhhhX
 Oz7WIzspzDO4MD4EclIQPym9Oq/WiDGLTaOzqlArVAUf383k6CugIFiaLGWkVXuvXknJyW
 EwDt8Q5SxeCreZt/aDEJ+VAmXjsdtpM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-oCyXbsw0NJyYX49NqETkSg-1; Thu, 07 Sep 2023 09:00:21 -0400
X-MC-Unique: oCyXbsw0NJyYX49NqETkSg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35FF62815E46;
 Thu,  7 Sep 2023 12:59:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC1A46B5AA;
 Thu,  7 Sep 2023 12:59:50 +0000 (UTC)
Date: Thu, 7 Sep 2023 14:59:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, William Tsai <williamtsai1111@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
Message-ID: <ZPnJRVnC13X25orb@redhat.com>
References: <20230904162544.2388037-1-berrange@redhat.com>
 <ZPbt0io6He9mE2SB@redhat.com> <87edja9vkr.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edja9vkr.fsf@pond.sub.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Am 07.09.2023 um 11:33 hat Markus Armbruster geschrieben:
> Kevin Wolf <kwolf@redhat.com> writes:
> > Am 04.09.2023 um 18:25 hat Daniel P. Berrangé geschrieben:
> >> I still think for user creatable devices we'd be better off just
> >> mandating the use of JSON syntax for -device and thus leveraging
> >> the native JSON array type. This patch was the quick fix for the
> >> existing array property syntax though.
> >
> > I agree, let's not apply this one. It puts another ugly hack in the
> > common QOM code path just to bring back the old ugly hack in qdev.
> 
> Since -device supports both JSON and dotted keys, we'd still offer a
> (differently ugly) solution for users averse to JSON.

I'm afraid this is not true until we actually QAPIfy -device and change
the non-JSON path to the keyval parser. At the moment, it still uses
qemu_opts_parse_noisily(), so no dotted key syntax.

Kevin


