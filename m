Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D387C022A
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 19:05:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqG9f-00084e-8i; Tue, 10 Oct 2023 13:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqG9c-0007xf-WA
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 13:04:21 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qqG9b-0008Ih-Ap
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 13:04:20 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-690d2441b95so30189b3a.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696957458; x=1697562258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZC41cvU7tbSLh3s5I52GQP/Db1iQGSjDYS21U9p8OSU=;
 b=WQXfFXYVZzUjVzPh6wBsRf5L9b0S1Jmf0Lh0qN+l58euVTMUcYuzyTKU4/mkT4DOUl
 rqkCjGWYsntyfS4mmf7KmAQ92vDlkJFdTkpUmY31Cbvu6uYHlmpuNgbnVZCpHGJaFuYS
 YJK9F1WyITglVdD13luOy3YJ1QkycrNMUF9vPdpnMMNju0CBF0lxL9xqzu2xLH7mmBz9
 Bg/xh9bkaaYQ/crG9C+Wax0mJOjLx0Vd0AEpN3KzfNBlSmWTtSPj5BwI8hMckyCRzi/c
 f/nGoQJOt1Ga2GmQKaVunGlpOymnjVojUXvWsSzQiNriXyISMySWNKcrtFO2E2ElrGqZ
 O7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696957458; x=1697562258;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZC41cvU7tbSLh3s5I52GQP/Db1iQGSjDYS21U9p8OSU=;
 b=nbeUhSgN1ZWZs5Io/cSkoRZoIYpzb3O0+oDbPm9P/d+Dph1dMSblY3n8hQnkmoawa+
 8vh4UwgR6uE26Gy3Su9CljlnXfhIJ+adwrd+BgZj6uf8vibdRt8Fqi/zjUeG+HlgOK9U
 +uh7v56a+MbSGQ7k9kRQXPzb3kyX2e2QzJYyNV7WVum5OlRe+OijEPmFo38+NDult1zQ
 ETROXdRLS9qL/qC3jR0BDqexmsuQaz99iNC9rJP8y/K5SRznRQTSXZ+E7KaViuFmxAek
 DrXl+jR+lrMGktbokOPuUJIbNNe7e2ZbVpBIJwPR3RjPHLnvo2OCaquL2mSA2FIEavSj
 HjAA==
X-Gm-Message-State: AOJu0YwnJc+EdyH2zc+V4j5mg80GDUnzje9bDej8bDhFDG8nOwiguGJi
 ZqcE7B+V0G+aLyRcXgZcnfmwTA==
X-Google-Smtp-Source: AGHT+IFEEncpqg+iTu6ICK8SkdbEGt8DHMZlP6L1LNG1A3LJpu+bpuoDYGt8ghtdYD1xyvQyRY9doQ==
X-Received: by 2002:a05:6a00:14ce:b0:68f:cdb8:ae33 with SMTP id
 w14-20020a056a0014ce00b0068fcdb8ae33mr26209091pfu.10.1696957457539; 
 Tue, 10 Oct 2023 10:04:17 -0700 (PDT)
Received: from ?IPV6:2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d?
 ([2607:fb90:b763:d52:6ee3:1cf3:f2d2:e12d])
 by smtp.gmail.com with ESMTPSA id
 15-20020aa7914f000000b00692c5b1a731sm8428752pfi.186.2023.10.10.10.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 10:04:17 -0700 (PDT)
Message-ID: <58838379-60bf-4af4-980b-cff8ee49bfc2@linaro.org>
Date: Tue, 10 Oct 2023 10:04:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] target/riscv: Use env_archcpu() in [check_]nanbox()
Content-Language: en-US
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231009110239.66778-1-philmd@linaro.org>
 <20231009110239.66778-3-philmd@linaro.org>
 <8e8b6cef-efbf-42ac-975c-b523dc24a531@linux.alibaba.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8e8b6cef-efbf-42ac-975c-b523dc24a531@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/9/23 05:42, LIU Zhiwei wrote:
> 
> On 2023/10/9 19:02, Philippe Mathieu-Daudé wrote:
>> When CPUArchState* is available (here CPURISCVState*), we
>> can use the fast env_archcpu() macro to get ArchCPU* (here
>> RISCVCPU*). The QOM cast RISCV_CPU() macro will be slower
>> when building with --enable-qom-cast-debug.
>>
>> Inspired-by: Richard W.M. Jones <rjones@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> 
> By the way, does the community has the plan to support heterogeneous architecture cpus in 
> one soc?

Yes.

> If so, maybe we have to do this qom cast somewhere.

No, I don't think so.  Or at least not in these places.


r~

