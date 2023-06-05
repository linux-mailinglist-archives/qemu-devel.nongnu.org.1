Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F08E972246C
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 13:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q68Dm-0005fW-Vi; Mon, 05 Jun 2023 07:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q68Dg-0005eL-30
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q68De-0005E2-G2
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 07:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685963869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lev2TTVdDu//NEgXNIdvJO2jIbHie4AXd8fODQcJ9t8=;
 b=hIJkixBo/kPV9hTAOloE6JJPrh/erX8Qo2d6ymBZcLqowAJrPTaupWhP77pEYqg4MOeagk
 SUQJEYZc5/j2uMh69JtiMuLibLZTIU44+IeW0mmZwYh/XCiV1KCtnZYP2enIlkGOudQt1E
 dwxdFoLYiuML/RVp6cspzx/F4YVHFb4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-vGBP1LVxMxqelElrm8e_jA-1; Mon, 05 Jun 2023 07:17:48 -0400
X-MC-Unique: vGBP1LVxMxqelElrm8e_jA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f7e6043552so2804095e9.0
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 04:17:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685963867; x=1688555867;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Lev2TTVdDu//NEgXNIdvJO2jIbHie4AXd8fODQcJ9t8=;
 b=aEfb5PtD6ooqqX7efbP7fsLbIHS8l1JMR+fPCS65hwt/n0rZYeL0wLAP88YaNUYeKq
 HyVIEAAfZr8cJem/JygIWE6h7MFtt3MftjUA2EEZ5GM5cCKhj0+zhcWBDuWIChLT7GjT
 xR2B74e3RaYBFAJAz8BILlVe1PxB0WhBL5oifd/izd8zwFs9gLHlkuwS22IngeKcpS6j
 Dy5ig7ErO7pkFq1nDtBAuVSMdtnFWqSeOpT8ivkMjtD2rJK82Rd4AzpHXY9dPrvK1Lrn
 ExuVvmHOfQxD0ytx1toBnr0XIA679DkRjwvVB0KpKNJMmTxJ2wW0SBBSZ3McjOdRmc1m
 CO2Q==
X-Gm-Message-State: AC+VfDzRSQCrfMN/n7dZWQdD3thcirMP3OTAyls2Gy0niL+mY/qeca7w
 37irnSO/RLSO1GirdZvTZtc4/W4dJYlvgWFDXUN30gn2jYD2tVodAmyyqcW7D0D60/hjb9kOBOC
 Q71iVDezeio176/0=
X-Received: by 2002:a1c:7319:0:b0:3f6:536:a4b2 with SMTP id
 d25-20020a1c7319000000b003f60536a4b2mr6317347wmb.27.1685963867306; 
 Mon, 05 Jun 2023 04:17:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ66Xl2cILsHXVuy2Xt/TD755mVrFslv6YpymvSAof4fR2d/Mzdux5AA73CmfJ5t91LQJ6LPZA==
X-Received: by 2002:a1c:7319:0:b0:3f6:536:a4b2 with SMTP id
 d25-20020a1c7319000000b003f60536a4b2mr6317336wmb.27.1685963867062; 
 Mon, 05 Jun 2023 04:17:47 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-115-143.web.vodafone.de.
 [109.42.115.143]) by smtp.gmail.com with ESMTPSA id
 d6-20020a5d5386000000b00307c46f4f08sm9487931wrv.79.2023.06.05.04.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 04:17:46 -0700 (PDT)
Message-ID: <940386bd-f357-23b7-0edf-8d555479b918@redhat.com>
Date: Mon, 5 Jun 2023 13:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 01/10] configure: remove --with-git= option
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20230605095223.107653-1-pbonzini@redhat.com>
 <20230605095223.107653-2-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230605095223.107653-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 05/06/2023 11.52, Paolo Bonzini wrote:
> The scenario for which --with-git= was introduced was to use a SOCKS proxy
> such as tsocks.  However, this was back in 2017 when QEMU's submodules
> used the git:// protocol, and it is not as important when using the
> "smart HTTP" backend; for example, neither "meson subprojects download"
> nor scripts/checkpatch.pl do not obey the GIT environment variable.

Either "neither ... nor" or "not", but not both, please.

With the sentenced fixed:

Reviewed-by: Thomas Huth <thuth@redhat.com>


