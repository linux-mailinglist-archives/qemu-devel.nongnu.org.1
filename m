Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2BF774D29
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 23:40:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTURE-0007JH-TB; Tue, 08 Aug 2023 17:40:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTURC-0007Iu-Rm
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:40:22 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTURB-0003Ns-Br
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 17:40:22 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-686f8614ce5so6090876b3a.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691530820; x=1692135620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f1VOusWuC9fQNWkqbdtcfwhPyROGALbQn1+AVSZmq4I=;
 b=tXEx6n2A8xr8w/bBTt7Y5ZVcKQQIhQm4YPccgvwmom1oAE0moLcJf/AJt4GlGwVGiz
 9U/QZM4Tl2F51qD20rTGGKNefvyOBLLzVh/rzEsxipXqDtb8KljMTzW0vzLzwO74eseU
 0ZDTxxUqij/mjjTLgWX0vTCgs1KfNPcxDIwCKxyLbtTuzusIIjVwK8QC/P2xbwd3EOh8
 6AEixaAMvLjUxrZVFMlH95UTUliWVWsywtegoitJbixhKkdwfljC6aEBHEgWsV76I0Wg
 EDjVypUOoGK9F4wlQIbpnSIwt3xTebrzNodHoaPsEtMB7dXHEdJ87Hx+q6YCRoK4ppkq
 CP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691530820; x=1692135620;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f1VOusWuC9fQNWkqbdtcfwhPyROGALbQn1+AVSZmq4I=;
 b=WFZvdDd6fOdj2V0wgSvhinDSLciIHRUVTSU17bTTpdu78rnw2cWDdph7ZzIGpH2wxR
 XTwtC28z6r6IHf5cTJYemG4rPT3Cu/pkLXdHIOtz0/zflznBUxdjxhlq1jUK4p7a4J+/
 SrBQ3lxEoQK4tGizafGXRN81m0bWndUyll7Fedu4W58MGZOVCKNMUKfW6IzUaWM9nTE0
 xObh8beAXJPp0AA95lvA1JSfhNbOK2DU87zqxM75TGWc5RBtjB+RWZRxifKJXEyluY6d
 oa1PRBj+WKjVh/SkRz3ya9rKpS5dOEQIpou5At60vh92DhtIDAUADttTtDozuki5RWq3
 182w==
X-Gm-Message-State: AOJu0YxTS5aAFqsvjSimnsLMEW8Srv0vreLb3zFbsKjr90fTra9IqrcQ
 zkWau81ajSwNOEnEgItah2DB7g==
X-Google-Smtp-Source: AGHT+IGW12nwF3d7daFz3UKFFwbO59AW2yydmzeHRKSL2qnvTu2TAmq8p33oysO5Ekir/J0EDg9Jow==
X-Received: by 2002:a05:6a20:4407:b0:134:30a8:9df5 with SMTP id
 ce7-20020a056a20440700b0013430a89df5mr1067962pzb.43.1691530819985; 
 Tue, 08 Aug 2023 14:40:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a62e815000000b005d22639b577sm8523128pfi.165.2023.08.08.14.40.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 14:40:19 -0700 (PDT)
Message-ID: <cc314fc5-8501-f819-f4d3-f3558b287ea4@linaro.org>
Date: Tue, 8 Aug 2023 14:40:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 17/33] Implement h2t_freebsd_stat and h2t_freebsd_statfs
 functions
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Michal Meloun <mmel@FreeBSD.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-18-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808060815.9001-18-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/7/23 23:07, Karim Taha wrote:
> From: Michal Meloun<mmel@FreeBSD.org>
> 
> They are the 64-bit variants of h2t_freebsd11_stat and
> h2t_freebsd11_statfs, respectively
> 
> Signed-off-by: Michal Meloun<mmel@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/freebsd/os-stat.c | 82 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 82 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

