Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E995FB59DDB
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Sep 2025 18:40:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYiE-00031T-Qx; Tue, 16 Sep 2025 12:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyYiC-00030z-CZ
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:39:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uyYiA-0005C2-Bt
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758040760;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U+r2RPqRFxieX89HZcUvpcuA4kwsISoSy/FvEW+iKKY=;
 b=KThkgh5M1AYsx9keWrxLgjonjp5uKz4cLWwVs445Yxhy+/lMo0gCUS67S07Q2m1np36cXw
 BjfSYUClU+1/HUDEEXOBRxkbaM4JtOhTLCeAWrLUVpVoCbX81Yj2Q3GTMCXRSKoEM7HL6h
 +v9jKFLYBRhlOJiGFs3lX16B+y6HF0A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-pOrYTtwnP6qMfLzIRfhzKg-1; Tue,
 16 Sep 2025 12:39:17 -0400
X-MC-Unique: pOrYTtwnP6qMfLzIRfhzKg-1
X-Mimecast-MFC-AGG-ID: pOrYTtwnP6qMfLzIRfhzKg_1758040756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A285B180057A; Tue, 16 Sep 2025 16:39:16 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96CC1300018D; Tue, 16 Sep 2025 16:39:15 +0000 (UTC)
Date: Tue, 16 Sep 2025 17:39:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] .gitlab-ci.d/buildtest.yml: Unset CI_COMMIT_DESCRIPTION
 for htags
Message-ID: <aMmSr74RjQlxIyHZ@redhat.com>
References: <20250916163030.1467893-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916163030.1467893-1-peter.maydell@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Sep 16, 2025 at 05:30:30PM +0100, Peter Maydell wrote:
> In commit 52a21689cd829 we added a workaround for a bug in older
> versions of htags where they fail with a weird error message if the
> environment is too large.  However, we missed one variable which
> gitlab CI can set to the body of the commit message:
> CI_COMMIT_DESCRIPTION.
> 
> Add this to the variables we unset when running htags, so that
> the 'pages' job doesn't fail if the most recent commit happens
> to have a very large commit message.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 52a21689cd8 (".gitlab-ci.d/buildtest.yml: Work around htags bug when environment is large")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  .gitlab-ci.d/buildtest.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


