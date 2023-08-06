Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 800F577149E
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 13:57:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qScMi-0005m7-Sf; Sun, 06 Aug 2023 07:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qScMh-0005lj-21; Sun, 06 Aug 2023 07:56:07 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qScMc-0004rN-Cd; Sun, 06 Aug 2023 07:56:06 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-686ea67195dso2583706b3a.2; 
 Sun, 06 Aug 2023 04:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691322960; x=1691927760;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dp2P8QXPDiLyJhzzRqS3jBy6aRrtMnLemVp29FfQwUY=;
 b=a4/9UxNQMCANYoA3jnnAzPgJRrOeojceu6yfexWFQXnmLP4FTsalgUp+0//BJqPFDn
 7kV5dIjp6T2rZ7XTdqfwnp8TIi/4WmWA7FVBv8Kuuv1XlSv+5UABM8SF4PaWNq0FOYKk
 hEDS05W6/koyLxo0O6Zy2fMBSsEb4DPq+CLowbMX5s9KSJWae2RncqhNJFiyZpSnkhHq
 dS7Zpr8CHQnN8qm8GSA9j6UqKY4fegxCoVCAzsf99tVK/2SdB/pmyW2VN308NfMYYKh2
 iMymOgwTrrXPSF6XUi918uK73jD8Tjv2MUsPGQj7lNhhpL3pnDmRshJktuQFBeir4g3D
 K8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691322960; x=1691927760;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dp2P8QXPDiLyJhzzRqS3jBy6aRrtMnLemVp29FfQwUY=;
 b=NYBoXNPzRQlfQQE6GAnMkGUDDMdVLbqrozclwKSoR/ThgtBi6X6qEqjaoZfEQyUFRd
 ygb3/7KuY0U56AHUhl1MYXaxL5I+Mvl49SGCprApwa111Odpp6TplzTZLauC3eptQVUD
 +2/abzxB6YdJvut4fgLAeyPIZUQ+LnYVC1qOLGQmTbx1XTxoaVvY6s7++KPLVyep/ReL
 rkq6VGSYNhaUKXZX3HrVGxFM0J56aDfEldzEqefKi8yGiUk1vGdZZ1dckMorbdlanw9b
 TAi6zEm2xpEZaAdTolf/UB67oJ3JXQLbqAgJyYT98FgRLzbOj0Xymznh01/tV5DbWAFf
 ANlQ==
X-Gm-Message-State: AOJu0Yx9Daj7KD54IB46vXNssxBkiDoBaQwoY9rGSfjP2OCtMpxMUdFR
 KKopAPGPug1jWETRiIlD2vodyAWs37c=
X-Google-Smtp-Source: AGHT+IHG62eSB/yhyWenTm+AojnUw2nuraojrKkzrNBQ68hmxAxriqxEdBgTJa9T2RTuBXRal+ABOQ==
X-Received: by 2002:a05:6a20:3945:b0:134:a478:6061 with SMTP id
 r5-20020a056a20394500b00134a4786061mr8629194pzg.26.1691322960180; 
 Sun, 06 Aug 2023 04:56:00 -0700 (PDT)
Received: from localhost (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a636f03000000b0052c9d1533b6sm3638681pgc.56.2023.08.06.04.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 06 Aug 2023 04:55:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Aug 2023 21:55:54 +1000
Message-Id: <CULFY7505V8V.16ZJ1H7XXFRVT@wheely>
Subject: Re: [PATCH for-8.2 0/7] tcg/ppc: Support power10 prefixed instructions
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Cc: <jniethe5@gmail.com>, <qemu-ppc@nongnu.org>, <bgray@linux.ibm.com>
X-Mailer: aerc 0.15.2
References: <20230804213355.294443-1-richard.henderson@linaro.org>
In-Reply-To: <20230804213355.294443-1-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sat Aug 5, 2023 at 7:33 AM AEST, Richard Henderson wrote:
> Emit one 64-bit instruction for large constants and pc-relatives.
> With pc-relative addressing, we don't need REG_TB, which means we
> can re-enable direct branching for goto_tb.

Very cool. I tested this on a POWER10 and it has been stable so
far. Using mttcg with SMP 8 machine, with this patch, a parallel
gcc compile job in a Linux distro is 11.5% faster. Is such a big
improvment expected?

For the series,

Tested-by: Nicholas Piggin <npiggin@gmail.com>

Thanks,
Nick

