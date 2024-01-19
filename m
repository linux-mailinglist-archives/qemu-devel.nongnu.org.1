Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E728323F6
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 05:02:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQg4c-0004pC-T6; Thu, 18 Jan 2024 23:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQg4X-0004oq-On
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 23:01:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQg4V-0002Iv-4r
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 23:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705636893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hJtF91LScsj/Ca7A0BDP7OhLzgM8MOMEfQgPCDYC4wk=;
 b=DX9xnA4BkpQJkxV+lIAL7JidbsuduorytNNlRfrbhKT8rNfB3X0Uz+c/SsBXck72hBJH1c
 V103Ey5zolffAJthJCGHfTAQ7mhEebIDnr3/HL+g73w/O0rpOFvKq4AQpHfelL22ZBwo7u
 LsXlQ9NZ2s4U7t68Vomo4YLizUdOCHc=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-yXVMCV82ObyzHnuU4PMJSg-1; Thu, 18 Jan 2024 23:01:31 -0500
X-MC-Unique: yXVMCV82ObyzHnuU4PMJSg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d99a379dacso108080b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 20:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705636890; x=1706241690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hJtF91LScsj/Ca7A0BDP7OhLzgM8MOMEfQgPCDYC4wk=;
 b=dRCmKOE8nZG/MORvOprkTKD+pnLagtKvjlqb2Mhqii5rfcWNe0ubCbTSnzgxH/qC9D
 pbVrLVwa9YETO/Ye5UBKl37gbZUTx7wi7/RVPcvVoVFILfllyrdw/2q+gH6bGpk3ysVW
 RYrmRmLthBH65KCDajHbWI0bZ8jNjbJfnFj9cBl2tP5ceEvCyG1fasivMiqVkhezPv/M
 XSu2z5vV0vWQT95n3AeSDgpkY5V1ouRYCn+cQqEtp4BKly3omiYa28fyeL3iQvvJIj5k
 53l2aivovuH374I7HIYaYq/RQV9Pgk/V5FQWdheIEciTdVbMuujn8MTsA23usyG/LpKj
 fh1A==
X-Gm-Message-State: AOJu0Ywyl469DmWR5Lc58EhetHDdPAKAeaS9+shp9FPRdlOHdAJWKmKk
 YZ9YzzM/LXp35uYiMv3yboSslGhiQtovkeTpAbXBty/vBABdgf2JwKkzYdA9xturiiOJ8B0k0Nr
 V1xf3yUk4WDVglKToS4v2Oe4o93B8CtXvZkRXkKar4Q5JyN3jVHCT
X-Received: by 2002:a05:6a00:3a22:b0:6d9:383b:d91a with SMTP id
 fj34-20020a056a003a2200b006d9383bd91amr3894265pfb.1.1705636889979; 
 Thu, 18 Jan 2024 20:01:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHNTu2q3D/7jHC9+HoCPjgD3CCWvoshq2kLO4b1mLXk5MnPva8AXPux1T9Hby6nkwhRxGFP7Q==
X-Received: by 2002:a05:6a00:3a22:b0:6d9:383b:d91a with SMTP id
 fj34-20020a056a003a2200b006d9383bd91amr3894247pfb.1.1705636889669; 
 Thu, 18 Jan 2024 20:01:29 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 z6-20020a62d106000000b006d9b0336a27sm4224405pfg.125.2024.01.18.20.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 20:01:29 -0800 (PST)
Date: Fri, 19 Jan 2024 12:01:20 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH v4 3/3] ci: Disable migration compatibility tests for
 aarch64
Message-ID: <Zan0EOYX1pEEzlFz@x1n>
References: <20240118164951.30350-1-farosas@suse.de>
 <20240118164951.30350-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240118164951.30350-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 18, 2024 at 01:49:51PM -0300, Fabiano Rosas wrote:
> Until 9.0 is out, we need to keep the aarch64 job disabled because the
> tests always use the n-1 version of migration-test. That happens to be
> broken for aarch64 in 8.2. Once 9.0 is out, it will become the n-1
> version and it will bring the fixed tests.
> 
> We can revert this patch when 9.0 releases.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  .gitlab-ci.d/buildtest.yml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
> index f0b0edc634..b344a4685f 100644
> --- a/.gitlab-ci.d/buildtest.yml
> +++ b/.gitlab-ci.d/buildtest.yml
> @@ -217,10 +217,14 @@ build-previous-qemu:
>      - QTEST_QEMU_BINARY_DST=./qemu-system-${TARGET}
>            QTEST_QEMU_BINARY=../build/qemu-system-${TARGET} ./tests/qtest/migration-test
>  
> +# This job is disabled until we release 9.0. The existing
> +# migration-test in 8.2 is broken on aarch64. The fix was already
> +# commited, but it will only take effect once 9.0 is out.
>  migration-compat-aarch64:
>    extends: .migration-compat-common
>    variables:
>      TARGET: aarch64
> +    QEMU_JOB_OPTIONAL: 1

Optionally you can move the whole migration-compat-aarch64 from previous
patch to here, then even if someone kicks off CI for previous commit it
won't fail.

Would QEMU_JOB_SKIPPED suits more here?

        https://www.qemu.org/docs/master/devel/ci.html

        QEMU_JOB_OPTIONAL

        The job is expected to be successful in general, but is not run by
        default due to need to conserve limited CI resources. It is
        available to be started manually by the contributor in the CI
        pipelines UI.

        QEMU_JOB_SKIPPED

        The job is not reliably successsful in general, so is not currently
        suitable to be run by default. Ideally this should be a temporary
        marker until the problems can be addressed, or the job permanently
        removed.

I suppose they all fall into "manual trigger" as a result, but just in case
it'll behave differently in the future.

>  
>  migration-compat-x86_64:
>    extends: .migration-compat-common
> -- 
> 2.35.3
> 

-- 
Peter Xu


