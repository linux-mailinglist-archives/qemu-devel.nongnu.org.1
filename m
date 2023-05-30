Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15592715E4B
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 14:01:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3y2g-0003kt-Hw; Tue, 30 May 2023 08:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3y28-0003i5-Ft
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:01:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q3y27-0002QF-2s
 for qemu-devel@nongnu.org; Tue, 30 May 2023 08:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685448058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2CiVNb+k9zPKo8GHj6Mmt4f+fPc/V6y4e00noFsJf8=;
 b=RUEtc+8f2ECgZAWKDrXX0cZFqpqMlDhMVgH3paEUVPivte2sA7p3YDd4vCFSyP1QOmlGv6
 DC7v+0NLJ/HuffZnOvehNvJNvIqpez/dBy2j8JwEqxy1fSDGrYwjPEpMyv54w8xXjs9cGV
 85/0fp1VE8zvpZzMVoP0Qb2/oqbCCCI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-k8Mjrp0GNy-LXuEnxn6D6g-1; Tue, 30 May 2023 08:00:56 -0400
X-MC-Unique: k8Mjrp0GNy-LXuEnxn6D6g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f70f9995aeso2276265e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 05:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685448055; x=1688040055;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p2CiVNb+k9zPKo8GHj6Mmt4f+fPc/V6y4e00noFsJf8=;
 b=aJH7jNHIyXD5Oi/a2XeqJINkdH04ctZyjQi28GgtVfJSHSaQ6S3+/KbSsxegAET6MH
 Slr6Tj3aacpP1DrPgrC0Zw3CdhuBxyn6C4+ChMJrW4gWDsUR6TgHIoLhtTnGVgNyvcw4
 +9r+/FhDzsXDL7yuMDLWCOVv9Ha72e5FMH0Kn1iBFocQep1B2waRdXlov9GhJWrdLyMR
 aob9RR/ROUZd5eJ65JnmwtmNHZprOwwO0lSDBhvsiLsi6ndnHM6iViun6mwT+9W42Qnk
 3vzkvEWoA0TLtQ7/tuA/+re2rAF5jXo5bR31PTx28zcCuALKlHUrg2tJsIVKbyzSrMM1
 YNlg==
X-Gm-Message-State: AC+VfDwy+TMpGzyVd68/5xMOz5S5KT5aiLyZXi+7BQrDhagcJAHUbtC7
 Ye5vxA6bkzp7bsLl1jKmHsOkWtmkxA2mvUSrzHA0idj3GrGs6cFal52nJHco2yzc6GZOqIKhbQY
 keiEE3ApOJMnm2AY=
X-Received: by 2002:a05:600c:3786:b0:3f6:5166:6da4 with SMTP id
 o6-20020a05600c378600b003f651666da4mr1411926wmr.31.1685448055564; 
 Tue, 30 May 2023 05:00:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Oj1Esm3bHjYYocKWpNntSNkW/q6CHu71bAlGw3rSrk97bC/Pv3SMcrZdGCmEkDC8sybNPCA==
X-Received: by 2002:a05:600c:3786:b0:3f6:5166:6da4 with SMTP id
 o6-20020a05600c378600b003f651666da4mr1411915wmr.31.1685448055315; 
 Tue, 30 May 2023 05:00:55 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-11.web.vodafone.de.
 [109.43.176.11]) by smtp.gmail.com with ESMTPSA id
 u4-20020a7bc044000000b003f6f6a6e760sm10705104wmc.32.2023.05.30.05.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 05:00:54 -0700 (PDT)
Message-ID: <a6f5f4eb-84fa-7604-513d-8451fa5fad59@redhat.com>
Date: Tue, 30 May 2023 14:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/5] configure: rename --enable-pypi to --enable-download, 
 control subprojects too
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com
References: <20230527092851.705884-1-pbonzini@redhat.com>
 <20230527092851.705884-3-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230527092851.705884-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

On 27/05/2023 11.28, Paolo Bonzini wrote:
> The behavior of --{enable,disable}-pypi is similar to that of
> -Dwrapmode={default,nodownload} respectively.  In particular,
> in both cases a feature needs to be explicitly enabled for the
> dependency to be downloaded.
> 
> So, use a single option to control both cases.  Now, --enable-slirp
> will trigger cloning and building of libslirp if the .pc file
> is not found on the machine.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configure              | 17 +++++++----------
>   subprojects/.gitignore |  3 +++
>   2 files changed, 10 insertions(+), 10 deletions(-)
>   create mode 100644 subprojects/.gitignore

Reviewed-by: Thomas Huth <thuth@redhat.com>


