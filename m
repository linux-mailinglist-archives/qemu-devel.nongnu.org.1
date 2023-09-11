Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFDA79ABFB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 00:09:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfp4E-0001Yk-Me; Mon, 11 Sep 2023 18:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfp4C-0001Yb-Bj
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:07:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qfp47-0007dL-6J
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 18:07:36 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c0db66af1bso32953215ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 15:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694470049; x=1695074849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LiA7p4VSwJlBQa86rm8n5jNAoUa+g4ZDQ6R3KzE63Kc=;
 b=HaqX6laiOSTOj/qqpFEM6ZmKO8qOHH+fwYfiWJD5VwkFQ3ezUtxY6z1jRRG3H9Ke9t
 negOaBXkY1rkaY18/eY+e5UJZkVxNX10Tk2DhJlw3ZPt4u+2QGQESfbaHwP9s/Ialkng
 9RL6869wAn7bWdUQujdI4aE2/cVahhf+diSpYs5RIzXfV0pl6glVWKs01SVJkdatGBOd
 jQ2I08fOMJaDm1jlvcOGDe2xfNIl0H+S+/mJ8j9GSbqzTl2pKLa+FFh1AM6bDuMY3VoA
 omQpasHFFfVt4Jxe7KatqXsMViVNNv94Al3mVrg+LS7nT+qT82dtffdMCrJPkTmGFA9m
 GRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694470049; x=1695074849;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LiA7p4VSwJlBQa86rm8n5jNAoUa+g4ZDQ6R3KzE63Kc=;
 b=qRIlCfFwx91O6p9Q96XFy4VYMYrDA6FXtHt1tV7We2t7QQPNq96rmFk00mVjsCbqam
 IBUzmCQZL0w3ntRhktCeIgt/12lGgZXLe83Q1ppNBBK8brpz2QHjCL/oIyAW3XT4dQxp
 C1Cchv1BXjZnATh6kOJljlMUlQlYv2oINUgtRoTaflXvlbhEUL2/lPVWjjQpqpsjY5bZ
 tmalHncnsZxk1bcRQcK5/ZkFAbFUS9BHdIHDW9lu8+8Ho8RVDbntbJ16BeTwOBf0C3xH
 GBI7fUbVgIU62rzDeO63097G8TAqVxHcK4R57PGTuIYWImbAbPtAI8tynK86qMrQCFGb
 FyNg==
X-Gm-Message-State: AOJu0YyzNkjW8Vo7gZFr1gZM9tfZZpADLNsCQychUdj9ZYici5pIuwcq
 lXRk0ciDDOv5x+qdxTtestuODg==
X-Google-Smtp-Source: AGHT+IHGoACLD59fwR3Uwq/mTBHJWWfEZbXVkj9zCD0shPGcm55XgdDUAxDyoZrurxDgIx0e1wAaAQ==
X-Received: by 2002:a17:902:8504:b0:1bd:a22a:d409 with SMTP id
 bj4-20020a170902850400b001bda22ad409mr8241985plb.40.1694470048822; 
 Mon, 11 Sep 2023 15:07:28 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 y7-20020a1709029b8700b001bdbe6c86a9sm6917193plp.225.2023.09.11.15.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Sep 2023 15:07:28 -0700 (PDT)
Message-ID: <7371a926-9cab-68e8-7453-ab794399bc2f@linaro.org>
Date: Mon, 11 Sep 2023 15:07:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH RESEND v5 40/57] target/loongarch: Implement xvssrln
 xvssran
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn
References: <20230907083158.3975132-1-gaosong@loongson.cn>
 <20230907083158.3975132-41-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230907083158.3975132-41-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/7/23 01:31, Song Gao wrote:
> This patch includes:
> - XVSSRLN.{B.H/H.W/W.D};
> - XVSSRAN.{B.H/H.W/W.D};
> - XVSSRLN.{BU.H/HU.W/WU.D};
> - XVSSRAN.{BU.H/HU.W/WU.D};
> - XVSSRLNI.{B.H/H.W/W.D/D.Q};
> - XVSSRANI.{B.H/H.W/W.D/D.Q};
> - XVSSRLNI.{BU.H/HU.W/WU.D/DU.Q};
> - XVSSRANI.{BU.H/HU.W/WU.D/DU.Q}.
> 
> Signed-off-by: Song Gao<gaosong@loongson.cn>
> ---
>   target/loongarch/insns.decode               |  30 ++
>   target/loongarch/disas.c                    |  30 ++
>   target/loongarch/vec_helper.c               | 456 ++++++++++++--------
>   target/loongarch/insn_trans/trans_vec.c.inc |  28 ++
>   4 files changed, 353 insertions(+), 191 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

