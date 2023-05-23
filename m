Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE19370E283
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:58:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VKe-0001SL-8N; Tue, 23 May 2023 12:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VKd-0001S1-1x
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:57:55 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VKb-0007Hd-KE
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:57:54 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-30644c18072so4961566f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684861072; x=1687453072;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GLU/OJC3bwnkx6g+3gLRDdZdD1pGVKxAPWic5gJDkaY=;
 b=cDiVsGgF0wFpXRhqyp41p5nt/BY2aAJWnvUtbS6ABRn9WIf6v9Mb9mWKzjWhosSmsB
 5gze1ySuVzlWeDEjfBBk5GkEugpurmoLsfQHv/UbMddKPlFBGDOJNUaZFV8hbOEMxuqI
 HyEQEb/qOSJl+0/yOYgPiFQWYBpqPl//+LNX14f+WDXkl1otSK49JM4O5Q1QVSDR6Jrg
 F8CbAZ8elmpI16gdtqtnPxs9rTFPSWQCgNy1anzNe1BQPJrZqta5lLffza/ISIaMM33h
 0QfEezKsm68BtMOJi/uV2B6xfSrqtvkCDnqyUxSz4hcduQqJhHzXyzQueV3J+vSvdpip
 +p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684861072; x=1687453072;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GLU/OJC3bwnkx6g+3gLRDdZdD1pGVKxAPWic5gJDkaY=;
 b=J0fAVcRC2gURniW8UjFMoBDl8tia2u9QiJzstBVc2MsTQRxdqp8qKpF4+c3EYTWY55
 X5a9vPoClIWo1RGT5A6yno/Nf4EHAeiPqZ2B7JNBPMNh90Ihp1fLXS4shc8eBsL/g88I
 8e5BjjQm0fgjYe7LvIJR6Oe1xGBK5KWlYTZmLuNW2RmuwPX2mGJcHKc7m978MitpIAVV
 PB1HnJ+ZYu0klmKrMwYxqaHIziY0gsy2HPaU2igBZMvwHEs/TO7iYxxhAb/KRMj0VmKw
 uC9xuSUvyQw7N6bGxxlIstzGt2VLoLn9e3zQ/KMxS8nYM+wUaGhGrnq8RKIwdPL1CA4H
 VLoA==
X-Gm-Message-State: AC+VfDxX+OAgag5LMUI2bs6t/tMH1sMY0Lj/QoCu9KkdM1EQUh7ZFVRB
 Rp2hTa0Fk8SPUTq/6JcVzNDwcQ==
X-Google-Smtp-Source: ACHHUZ76jJ/oYqxcaCBNt+PDk6OFUmpVtSgJ3hPFSJ8TxHEtBaTKnIHg6qhXcVMNYFhNj/f6Zd23cw==
X-Received: by 2002:a5d:4dce:0:b0:309:4243:f38 with SMTP id
 f14-20020a5d4dce000000b0030942430f38mr9972955wru.35.1684861071775; 
 Tue, 23 May 2023 09:57:51 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o2-20020a056000010200b002ca864b807csm11948800wrx.0.2023.05.23.09.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:57:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 134D61FFBB;
 Tue, 23 May 2023 17:57:51 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-27-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 26/27] qemu/atomic128: Add runtime test for FEAT_LSE2
Date: Tue, 23 May 2023 17:57:40 +0100
In-reply-to: <20230523134733.678646-27-richard.henderson@linaro.org>
Message-ID: <87r0r7x9ww.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> With FEAT_LSE2, load and store of int128 is directly supported.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

