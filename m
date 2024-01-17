Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 050548305A5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 13:41:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ5EM-00053P-7v; Wed, 17 Jan 2024 07:41:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ5EH-000537-Ai
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:41:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rQ5EF-0002CV-Qv
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 07:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705495271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iH6FEOObPu9ZjXI5OkZHTMSAWtGDIL70dtcsdAdycpk=;
 b=CwmIRytQdpijtvb+AIczhZ/GWXMYqiNd5QxvCCOiisZ69O0sW+mP3ejb0EDlA5EW128mHT
 ikAiwkUL1DX3nGUcTxSG7yQb6TfyonCe/Fcjb0hYF/XProb++VMgJuWUK3QCa+5u545FIa
 qxqGutn8ClWP5FhYqHojQVaX2ocW5IM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-Pbe5hjQFMz-GkmFXpDjYMg-1; Wed, 17 Jan 2024 07:41:05 -0500
X-MC-Unique: Pbe5hjQFMz-GkmFXpDjYMg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5C9A10AFB50;
 Wed, 17 Jan 2024 12:41:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B430B492BE6;
 Wed, 17 Jan 2024 12:41:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADD5921E6806; Wed, 17 Jan 2024 13:41:03 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH 4/5] qemu-options: Remove the deprecated -chroot option
In-Reply-To: <20240112100059.965041-5-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 12 Jan 2024 11:00:58 +0100")
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-5-thuth@redhat.com>
Date: Wed, 17 Jan 2024 13:41:03 +0100
Message-ID: <8734uwjfog.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> It's been marked as deprecated since QEMU 8.1, so it should be fine
> to remove this now.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


