Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F577DD6DC
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 21:02:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxuvk-0001dw-3A; Tue, 31 Oct 2023 16:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxuvg-0001c1-Q2
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:01:36 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxuvf-0000Vv-8D
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 16:01:36 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1cac80292aeso41819475ad.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 13:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698782493; x=1699387293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dyHW+IzvVO/X8u8bLfdCHecuwVEMEMcJx3Qp6+W4j+M=;
 b=gY5EuEkb+gOJYQWiyihDKhKWd1LFr8Jzc1OM+Y7vuEGczKq2jjZRQFDiFY4zukwJTu
 26HdiTMzNyBStq3lvPzTncZG9KeGQZJhiBjp6oxcyndbicstqLOpB3Q9pDvfa6FQmE+q
 zYdNKIT1KCiD3ukQNbPwRB/qdBsbs1KmpisiWsKovIImjhRBssPcmBjJZy+UuabOxEsa
 7OA10/1KE/TVIvvyoEpIDWHn+SgpLQhacoVtM4iP7Bhxo4eJz1iJON2e7QQNGWs+Btoe
 JL/gxO7O1EjYW1bOEUTYLp928ClDP9o5A1tWDQkNauT2A42lpuSh+zpXzGDOBshol7yz
 Gcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698782493; x=1699387293;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dyHW+IzvVO/X8u8bLfdCHecuwVEMEMcJx3Qp6+W4j+M=;
 b=p5IWxqjnZa4faGAjLIc2Meht+l23NWMbFC/2AY/TKXa3ORuvCT7s3MKx4cSaeFzUVe
 1YeQ/By7LRDrridS+uulXtbJrT3vzDRcUU86XwZ8cpL1admuxiYK8TkcZqAwSJPQ3gI4
 Kuq9XHzo6lrQKnza6ecKWUEugJolIIDkoYrrm/S56b5UZPjXL4pZN66ddnEq/rJRi7IG
 rb2UaxiYLWUvlpuNd6zdYn+OtTv//OL7o81jOwuNmLEorFaizYlxSjzMwTXF2m/e5bne
 30Tn8S93kdA5W+RebDxzif5Aa0jZ111zjKJIIBDtP6ufTSA2Lk5yGSvOAFthCoNYn6Ee
 uWMw==
X-Gm-Message-State: AOJu0YyglNL8OinkIUTCt4qBVmd+ob6YdLYIw3oBmGMSIcLSAngKT2Rw
 4ncO3+0ph6DhLJ5KFqX3eCHkyDw/b1tqtD4zUVo=
X-Google-Smtp-Source: AGHT+IEeScQgXqHaRZO++zj5bw4RLX4m3PJHvvlpiG4VzogPZury57siW4tUG/heDLHtKiJA2jwWYA==
X-Received: by 2002:a17:903:1053:b0:1cc:31a7:88cf with SMTP id
 f19-20020a170903105300b001cc31a788cfmr6782682plc.40.1698782492863; 
 Tue, 31 Oct 2023 13:01:32 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 w15-20020a1709027b8f00b001c73701bd17sm1685236pll.4.2023.10.31.13.01.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Oct 2023 13:01:32 -0700 (PDT)
Message-ID: <0f79c025-25db-48a1-a16e-b3fd5e07d98e@linaro.org>
Date: Tue, 31 Oct 2023 13:01:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Missing CASA instruction handling for SPARC qemu-user
Content-Language: en-US
To: Luca Bonissi <qemu@bonslack.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <4a785697-de37-3a3e-bf38-b20044cb56af@bonslack.org>
 <b542dcc6-8e74-4790-d8a2-d6c6e60a3a57@bonslack.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <b542dcc6-8e74-4790-d8a2-d6c6e60a3a57@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 7/18/23 09:09, Luca Bonissi wrote:
> On qemu-sparc (user-space), the CASA instruction is not handled for SPARC32 even if the 
> selected cpu (e.g. LEON3) supports it.

This should be fixed now, with

commit d0a11d25f0332dbaeb3a4f733a5cfb23ed40413d
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Thu Oct 5 00:09:36 2023 -0700

     target/sparc: Move CASA, CASXA to decodetree

     Remove gen_cas_asi, gen_casx_asi.
     Rename gen_cas_asi0 to gen_cas_asi.

     Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
     Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>


r~

