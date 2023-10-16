Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA01E7CA323
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:01:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJTM-0002NB-Np; Mon, 16 Oct 2023 05:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJT6-0002GY-Gu
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:00:58 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJSy-0003Td-IG
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:00:56 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40566f89f6eso49045515e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697446846; x=1698051646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=F6Y/C9DiztGjFTvikOxvNBXBPvbl/HxXELm+35BIOSs=;
 b=DQwHCe7JYnsQyXydKnOIDMY0hrJfFpQbbbkHAYVyOPkXm4gwiLr+u8b9/mVfQdQbRR
 eIe7kRk8XrK2mVjg+AJjam/BtrYoROHRf+hutyHglu571cA0fozytSyVGv5igXmv9iiJ
 8jIE8MjrXei8BXQOAcxpgR6kJNmxj1x+bmwpHli734q41cAob0Xosnr/WXLewQqVq902
 +czQjG4v4samL6mqSys45onGyApH6Cc/n4Zlq4rTYZOY5QHgxlNQrPLcKKRVs/uCCKBO
 OaPYeZzEXS/xfvlQ3Cu0ER80r+XvN2X3QDCaQsMZ6netrHWhpqqGT3f78XVcyShhm15X
 i33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697446846; x=1698051646;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=F6Y/C9DiztGjFTvikOxvNBXBPvbl/HxXELm+35BIOSs=;
 b=iVccnpp1lQMh45KGXLaqtZIUwvxENirlzjAt1LdoTClSjnhNvUPd7vWmGwqs5A0c3d
 XO0pSPeDU7lUzVPDp3SfJbWLanfMIlk+NtepAO2BYuyApmX0Y+2/frLZC8SE66r5QCKc
 ajs7nNnpomcs1psmtosXv/kI0r3dP6SJaCW1qiNyob+jWWq3OSIHPecTGYoAnP5z4DaW
 Ty3yWUfGTwJoQv6VaoqBKk/U8mr80mQCFFEYpCV1nNMh4KZM0IobQOD+wMZl9eukIlYL
 0BeZzmlmHTRuR22rNAUN47DYkJOXAJ2RieiU28+OnqcCf7bKDDL4Hq3/Qf4NF2G2xolO
 /SuA==
X-Gm-Message-State: AOJu0YyCr5ZvWTAH7eteA9X4MicWR/DbaAOGsHPiVD1R/qCAsWAoICt6
 FJBBQOZp2q+Ya3SsnEwuZh4Q0eAlmmdu+4t6ANk=
X-Google-Smtp-Source: AGHT+IF8x7l3B8fm+WpD8InbbFWIxDDU7cJjGHd+nfwdvo+dViPWAg3ZxXWl3BcnTWIrF2fpROzW4Q==
X-Received: by 2002:a05:600c:21d1:b0:406:53ab:a9af with SMTP id
 x17-20020a05600c21d100b0040653aba9afmr30498354wmj.10.1697446846417; 
 Mon, 16 Oct 2023 02:00:46 -0700 (PDT)
Received: from meli.delivery (ppp-2-87-17-65.home.otenet.gr. [2.87.17.65])
 by smtp.gmail.com with ESMTPSA id
 z15-20020a05600c220f00b0040684abb623sm6529436wml.24.2023.10.16.02.00.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:00:45 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:00:09 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org
Subject: Re: [PATCH] tests/docker: avoid invalid escape in Python string
User-Agent: meli 0.8.2
References: <20231016062300.160160-1-pbonzini@redhat.com>
In-Reply-To: <20231016062300.160160-1-pbonzini@redhat.com>
Message-ID: <2m6d8.vlbgyqc562pl@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Oct 2023 09:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
>This is an error in Python 3.12; fix it by using a raw string literal.
>
>Cc: qemu-stable@nongnu.org
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> tests/docker/docker.py | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/tests/docker/docker.py b/tests/docker/docker.py
>index 688ef62989c..3b8a26704df 100755
>--- a/tests/docker/docker.py
>+++ b/tests/docker/docker.py
>@@ -186,7 +186,7 @@ def _check_binfmt_misc(executable):
>               (binary))
>         return None, True
> 
>-    m = re.search("interpreter (\S+)\n", entry)
>+    m = re.search(r"interpreter (\S+)\n", entry)
>     interp = m.group(1)
>     if interp and interp != executable:
>         print("binfmt_misc for %s does not point to %s, using %s" %
>-- 
>2.41.0
>
>

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

