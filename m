Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD8070E183
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:14:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ue9-00080A-La; Tue, 23 May 2023 12:14:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Ue7-0007yN-PW
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:13:59 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Ue5-0004Q9-Us
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:13:59 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-30a892c45c4so2151079f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684858436; x=1687450436;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWe3IEhRu22CEOKIzCy2BHmYpeITcXs9fYDnp4aC0OE=;
 b=fblGSJ5AwFdDeDFBAuIsMocAIlx2CP0Fii9Je4dbvd3eKwjZazBsxVBH+yYOJllf25
 QnvTNn0Rrkk/mIIMXZRf7u+QuNDBmrJhUYZhd70TLg55Ka1BIhbS4WWLhK/XR9U0LMN1
 FLWcx8V2e35OgP6rD7simx/Y9k0bROcirMHldCp8blihHeD3IeexggYhzTElcQY3u9bn
 PZcX/HgzA9LjuKjhVw4wFy4jW79ghrblfyv9e6/7R0sdrM7Ff61UPPoWmmAt+fYnH3Gd
 dykD9DTVapipPB8rmAovrZlDR6r6fdyEqtTPtmeDLvGYem+eYb/zzc2WRfiQXDn4OvCs
 VCYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684858436; x=1687450436;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dWe3IEhRu22CEOKIzCy2BHmYpeITcXs9fYDnp4aC0OE=;
 b=JsoHeRmOVs5jARCdNcj4vkD8XPJcXoHd2kguO22uaykQ8dGJ0c3jJQDU3zqtF+eNhp
 ZhXglfZZreM4jbjNF6k4VmHLYIZvs6Y/hnYvm1oLutu4Bqj+HuZYSJi/t9v4BWzrdCZW
 rvivnXWVJP8R5e/PELQ9HfFttnb3IrQTZfTB0imxxXnqi1kgyW9J9EqsYCnAW/xxIHON
 1TAX68m85S6L39tbydG4om1i+G+6U44AE1YXK8GKifz9GIZccvXdxy4u1Od/zMQriTIj
 h13XS+XDKDrSQNy29iauVkj0sIRR8apiO6cc3KdZtif0OPrOG451oj06EOWtc/c5D/cG
 r79Q==
X-Gm-Message-State: AC+VfDwguU7KFoxUkc44QGxnAIBE16JhELJG4l0pdt33aMcLuHSruRmE
 JdTe97lGGqPkEJKF4cy5NWCbmA==
X-Google-Smtp-Source: ACHHUZ4VdhGMAd/bUFthuxaeVkiZEzIUIQbaVlnvY+fafxN4zecW0OU77mucBlccVIerabBk8NP3cQ==
X-Received: by 2002:a5d:4532:0:b0:2f7:e3aa:677a with SMTP id
 j18-20020a5d4532000000b002f7e3aa677amr9207371wra.46.1684858436162; 
 Tue, 23 May 2023 09:13:56 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5d4ccb000000b0030631dcbea6sm11484455wrt.77.2023.05.23.09.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:13:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 616941FFBB;
 Tue, 23 May 2023 17:13:55 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-4-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 03/27] util: Add i386 CPUINFO_ATOMIC_VMOVDQU
Date: Tue, 23 May 2023 17:13:47 +0100
In-reply-to: <20230523134733.678646-4-richard.henderson@linaro.org>
Message-ID: <87edn72fgc.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
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

> Add a bit to indicate when VMOVDQU is also atomic if aligned.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

