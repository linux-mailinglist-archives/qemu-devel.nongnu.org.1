Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D89E79213A
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 10:59:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRtw-000382-BZ; Tue, 05 Sep 2023 04:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdRtr-00037k-G5
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:59:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qdRtp-00008g-3i
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693904342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P5u2oX3kX0Ob2tPbEvLE4ybHtpQETEBFkrHgl7HEvyE=;
 b=QHHypPIvieCLYGFnt/TWDAXxbhFoZWZejL7YXGe5izXXkQSy+jGr2Gnreurpe0T9OpsJOy
 QXulnnal87AfY/K3hZ4S3R7e3YQEJj1mra9Q1pTdp1m7jRFJXAnN3lH6m3QYyTdupGFP0R
 VycXdKYt9tfmqqWpQt0MlJv8Xkj06/Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-kyudGXcuPXuZRE5uxrnLEQ-1; Tue, 05 Sep 2023 04:59:00 -0400
X-MC-Unique: kyudGXcuPXuZRE5uxrnLEQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 61A3F8015AA;
 Tue,  5 Sep 2023 08:59:00 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.195])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 528C1493110;
 Tue,  5 Sep 2023 08:58:59 +0000 (UTC)
Date: Tue, 5 Sep 2023 10:58:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 William Tsai <williamtsai1111@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 0/1] qom: fix setting of qdev array properties
Message-ID: <ZPbt0io6He9mE2SB@redhat.com>
References: <20230904162544.2388037-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904162544.2388037-1-berrange@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

Am 04.09.2023 um 18:25 hat Daniel P. Berrangé geschrieben:
> By the time of the 8.2.0 release, it will have been 2 years and 6
> releases since we accidentally broke setting of array properties
> for user creatable devices:
> 
>   https://gitlab.com/qemu-project/qemu/-/issues/1090

Oh, nice!

Well, maybe that sounds a bit wrong, but the syntax that was broken was
problematic and more of a hack, and after two years there is clearly no
need to bring the exact same syntax back now.

So I'd suggest we bring the funcionality back, but with proper QAPI
lists instead of len-foo/foo[*].

If we ever want to continue with command line QAPIfication, this change
would already solve one of the compatibility concerns we've had in the
past.

> I still think for user creatable devices we'd be better off just
> mandating the use of JSON syntax for -device and thus leveraging
> the native JSON array type. This patch was the quick fix for the
> existing array property syntax though.

I agree, let's not apply this one. It puts another ugly hack in the
common QOM code path just to bring back the old ugly hack in qdev.

Kevin


