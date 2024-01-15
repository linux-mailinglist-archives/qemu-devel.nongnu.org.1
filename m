Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FCCC82E92C
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 06:22:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPbsX-00058r-Fv; Tue, 16 Jan 2024 00:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPbsV-00058b-8M
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 00:20:47 -0500
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rPbsT-0007PT-MO
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 00:20:46 -0500
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3606dc4fdf2so54466885ab.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 21:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705382444; x=1705987244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6CSULuw61l56HmI76droEa5GBvffhr/lG/FORuQYZVk=;
 b=FHL0P0LtGsXHJ7mulmdOhLYDNixoJ8duOno2wZKDcwipbia+Ru7mynHdr1l1Q71Ywo
 88L1i0qALVQW26kFJvcgeP5nUse3jMd4QNifaPLcmdeWt+xlDrRi4zN1xHDf9iNMtPB2
 NhYfehVGkqKJD4+OjpPPGb+y26p9uIzPSI88pN1boHRJV93TmR+x6czVexcOSh3rB+1c
 jZel3bzWFgzoOuUZIRqH1sd0nlgCVIPVehqu+jlbdqCmMEDr0NRSXpJJEvYGc7sziLGr
 FOd9b+WGVZF7yQyM/vVt1JkGctX++JGc/K8fwseIxfFyDV4KSsui/qsPMtuJ0yoWYsv3
 HsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705382444; x=1705987244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6CSULuw61l56HmI76droEa5GBvffhr/lG/FORuQYZVk=;
 b=Cc4InRqRodKP9HpJoWnkdj19ZiXzHDUX5FS1wthz8kApc0UFhlzJuMA1U271NH6BQb
 Y3wnZi6fIlQ25KvfrmEXwI7hLj7U0EjjDPODAuR9pMz8VltyPo6tJ+WkEET+CoKPFO9b
 L7XbYFLqaaQ2lvS1nh32rHEQTWTGh/gkNEAn6sKWFhKxiS6ULMuuUYD9jcWwP35zOlzy
 G4IGmTPtNbvlFjeSgGI4sN4x6Gns23wczWsM7ARd4O9t4d248WCr5NNsXyPy/KTZDGif
 wOm6Fv8DQMwgIxExH80EYzz/bE8l2v60K4Hud3yinlvo+GbEIEu4FaaRUdc5EVorz+te
 tpvQ==
X-Gm-Message-State: AOJu0YyMXJoR7kf6nXOGoC8gwQArDNp2g4gMACzHPpLgurjONz0kWRhD
 ARMY4sahCEG67VG0wwb4XKoxkv2ydLdTLw==
X-Google-Smtp-Source: AGHT+IGwQYeODwggty5jJTtzW4cRAAKA6Zz6l2PGfW3DW/k7IoLi1S8MM3IWR73MRhAuSiJaMG575A==
X-Received: by 2002:a05:6e02:104b:b0:35d:61e2:16ed with SMTP id
 p11-20020a056e02104b00b0035d61e216edmr7670004ilj.9.1705382444016; 
 Mon, 15 Jan 2024 21:20:44 -0800 (PST)
Received: from ?IPV6:2001:8004:2738:1dd9:3a9f:3a7b:2ecc:95d4?
 ([2001:8004:2738:1dd9:3a9f:3a7b:2ecc:95d4])
 by smtp.gmail.com with ESMTPSA id
 y6-20020a636406000000b0059d34fb9ccasm9183510pgb.2.2024.01.15.21.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 21:20:43 -0800 (PST)
Message-ID: <9bd5405e-ee88-4508-b542-54600c7514a5@linaro.org>
Date: Tue, 16 Jan 2024 09:47:14 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] target/riscv/insn_trans/trans_rvvk.c.inc: use
 'vlenb'
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 max.chou@sifive.com
References: <20240115222528.257342-1-dbarboza@ventanamicro.com>
 <20240115222528.257342-7-dbarboza@ventanamicro.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240115222528.257342-7-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12f.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/16/24 09:25, Daniel Henrique Barboza wrote:
> Use s->cfg_ptr->vlenb instead of s->cfg_ptr->vlen / 8.
> 
> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
> ---
>   target/riscv/insn_trans/trans_rvvk.c.inc | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

