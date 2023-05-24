Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 246FC70FFF6
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 23:24:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1vx7-0005MD-NG; Wed, 24 May 2023 17:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1vx4-0005Lj-2v
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:23:22 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1vx1-0005lg-RQ
 for qemu-devel@nongnu.org; Wed, 24 May 2023 17:23:21 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ae408f4d1aso5996785ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684963398; x=1687555398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+HGNVhLu2U0D0HobTIQx00vJiG2cwE7AoCKAbhfxTqw=;
 b=L5IumfIKYsz+p96EWs9W/UMUhV6aiwYnH//wkkcKClHJRDtWUFP90nCQ9CGrlVXZE+
 UA8/WXrRCwvhviMA9sdgzs504xx+czLO0T3/vRQpmB75Siqtw+nXTNIHSgyk3gnkIsoQ
 h8N7Ksr3ziJ7/Ee8oXNtHMuxP2XSx8f5QZNUFRz34yAEBevk9um8nqp7j5POg7uY+PbC
 fVd+a0hbB9ui/kKiCH3zg9N+CamOxNW6PVdaVtDeIUKMiCaOOZhDX/GFu3VUVfCVPTWH
 Ks4MeyM5tbgtms2RpLysWoRCDPW3koH000yFcSvmuy0lOQucH9zXuJ2mW6QNcXiFscWd
 6kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684963398; x=1687555398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+HGNVhLu2U0D0HobTIQx00vJiG2cwE7AoCKAbhfxTqw=;
 b=iT6t8atA6pu3vJdWVB4lL6LARumVf95K7KGs/KbGtswoQ4MP2KzJJyUNsgrCumsDCb
 7soyOgpl28CdpEYzgnNCLHPxMuLh0Uf+yzscAgUJFAKuxiQl91TTEMGqXHaJUggqw60U
 IHEZYAggfO5mfyDbHvizGyrAheWYw/jAccu/DbeoHu0gKxkcIDrZefl3d4ZSefohQHlI
 Ug4wVhn7dgngAVM+GbAnUeg5ur1p18Pq7hAz3oTEWRQS1mjqSisMgY/Z5V+Hp1Un9E/2
 iFIBzKd7NUbZkxtw9G23klVVPt3qFLkLJlV5jMQLynKfrRX8mgre5LmFGTtw4fxoeW50
 6M8Q==
X-Gm-Message-State: AC+VfDyarMLb7gdd+15XZ4t+TTS5Aw+SWhQlt8uQRWOe3IlSdgmOFAx2
 OehnVCEryiejMN/h4K4znmqb/A==
X-Google-Smtp-Source: ACHHUZ5bzQLXYVfkPwyjKU0M7ignnPA/sxwDZF4y6Y7bbfG4o8RcDv55p+J5KoNL7Z3PjJ3zflQm5A==
X-Received: by 2002:a17:903:2689:b0:1ac:8837:df8 with SMTP id
 jf9-20020a170903268900b001ac88370df8mr17503946plb.6.1684963398225; 
 Wed, 24 May 2023 14:23:18 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:6b03:9af2:33c1:3d6b?
 ([2602:ae:1598:4c01:6b03:9af2:33c1:3d6b])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a170902654700b001a9a3b3f931sm9348838pln.99.2023.05.24.14.23.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 14:23:17 -0700 (PDT)
Message-ID: <899d9eb3-f613-b2b2-fa58-04a22a4065da@linaro.org>
Date: Wed, 24 May 2023 14:23:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Add CI configuration for Kubernetes
Content-Language: en-US
To: Camilla Conte <cconte@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com
References: <20230522174153.46801-1-cconte@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230522174153.46801-1-cconte@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
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

On 5/22/23 10:41, Camilla Conte wrote:
> Here's a second version (v2) of patches to support the Kubernetes runner for Gitlab CI.
> You can find the v1 thread here: https://lore.kernel.org/qemu-devel/20230407145252.32955-1-cconte@redhat.com/.

Applied to master.  With the k8s tag on the azure runner, it seems to work.


r~


