Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC92C7EADD0
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 11:17:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2qSY-0006n4-BL; Tue, 14 Nov 2023 05:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2qST-0006j5-DS
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:15:49 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2qSR-00062L-4g
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 05:15:49 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-53de0d1dc46so8825418a12.3
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 02:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699956941; x=1700561741; darn=nongnu.org;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9lFVJsfYiR2lMORizfhfXlce+b8qvXAA7n//bnuz8o=;
 b=nWMirIW2ef2Nqs+9x5Mwq2R2ZPv8VnQMiv04Dt4VLFI697iWn9KlFu8PKwiB5kOyl5
 O+sULoayzTS94z6hSZVRoGyAEuEsL1TNqS/aPfSxTxGhTbdE6SCcWuppbnY99Hf/JVIo
 gz42PKr0XC+r8tVSqDE3BAvqDMf7gzPYxxG2rPKkJ7L259Zhn0mA7TlHQ1wrf1ZkggLf
 XRIHjgmpjG2ftA9OaV9BRKjphu86ZhWvTItJkk6PeGqoIki4uEIqA4bhxS6J/Wykr9YT
 cxN16V3cfp6rA4kNIyQI5O5vQbO00XnHqDYm6sa14AekPuvFXcj9xxtsX6qv+lq/yJ7Z
 a1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699956941; x=1700561741;
 h=content-transfer-encoding:subject:from:cc:to:content-language
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=G9lFVJsfYiR2lMORizfhfXlce+b8qvXAA7n//bnuz8o=;
 b=VSX5OAyFtz9yUt1UtdLSI5W/sKtyzJW1CnclpHE3Ut41bMBUpsK6k5S7yngbrt/I3M
 0aVvlOxdvvK7auGSkvJQneHFx51m3LHiXa8zE/cWi3Oi0ZvU8GJcVC4C4HAYZzutE4Ub
 XJ80oQQoewn1Tzo7+3KZ98YNYgsQaT0CcWe6jiNQoRl8IaKUvexjA4ayKdSNUHrlejOu
 HOAhpUX/GSv9Vl20D6ZBlQti0N0ztdp4PUHLR8tOHsTh7hQNaQyygUiy8NpifL1kwpL4
 GOckelzTzT/52+tqGemMGtn6Qx77VLUjJM8XFx691E2ZWV6gjLYGP6CjsXFaNHBKXXoQ
 UN7g==
X-Gm-Message-State: AOJu0YxFI+bnCJsg5ZnQyv2w95nF7PPBAj7LYjHgXwtRuYr/DwAfiATI
 uLf2TZQ+5z1GQwn/9OgTLswzh/tUpQzjhcB6r44=
X-Google-Smtp-Source: AGHT+IFE4FA33euaz8Q1TamqydGPGhC3P5CYvEi75/SHfGlKPjrSQ+g73RAvZ/fmhsawJHEkRU53eA==
X-Received: by 2002:a17:906:7708:b0:9e0:9d26:420a with SMTP id
 q8-20020a170906770800b009e09d26420amr7307729ejm.65.1699956941500; 
 Tue, 14 Nov 2023 02:15:41 -0800 (PST)
Received: from [192.168.69.100] (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 c26-20020a17090603da00b009adce1c97ccsm5267640eja.53.2023.11.14.02.15.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 02:15:41 -0800 (PST)
Message-ID: <0bc17e75-29a1-46ee-a395-b129c2d1dead@linaro.org>
Date: Tue, 14 Nov 2023 11:15:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: MAINTAINERS: sundeep.lkml@gmail.com bouncing
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Sundeep,

Your MAINTAINERS contact email (sundeep.lkml@gmail.com) is bouncing:

452 4.2.2 The email account that you tried to reach is over quota. 
Please direct the recipient to 
https://support.google.com/mail/?p=OverQuotaTemp 
w3-20020a197b03000000b004e7fc2bc901sor1128110lfc.3 - gsmtp

Do you mind updating your email entry?

Thanks!

Phil.

