Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE1F72F77C
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 10:13:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9Lc8-0004bv-3M; Wed, 14 Jun 2023 04:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q9Lc6-0004bZ-S7
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 04:12:22 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q9Lc5-00042D-Cy
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 04:12:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so65244566b.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686730339; x=1689322339;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WKzNFZIdAnfIeuFjQBvoFl5Yqdjnzufg9J/XNJG8l1A=;
 b=T9OqN9ZQAKu+nJWPZDSsUY0YvyltAM3mANsfcH7Tnlssb+4N/gSSbHi7a3CLeUke2q
 TtijUjDVRrTJk22aHZHbqGr2p5x+7zKagybQLVf7abYUFyH32jWQNV9j9zbE+PZx3jdm
 o3G3OM72rIyqeQkRxYoOhjd0OpaJtHj/v4SQtZhdg9Y8FO63XyLiSdLJOIUYcV7LgeOJ
 k0n3eo8ib2fPFsym2xjvQ6kD8RJRZ5inD1a9h9HS9Xu66C2G8lO48QiUmZaMAauueUB9
 D+fyuGG9Zfk1FHjBL/waDXLw1aO4hPBG+YNNmuJWD/B/lQutqYmO8uA92waA8f2W2YfO
 ZUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686730339; x=1689322339;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WKzNFZIdAnfIeuFjQBvoFl5Yqdjnzufg9J/XNJG8l1A=;
 b=HFfc4htDylxrEI9URu4bTqRiZszw7JLTwF5ceJVxjZoGxHwo5qHui7CbtgeZflLNwb
 u/dwTbPEZ2knanQw4XktlLrcbk3iRSF5EigMljKPNE1cF1vKmisInOLMpnsxcWhwdVYv
 vuIm8x3gTTpXG/PT6eptjwBdZ6O0Sb77U+NtW6eEw9fK813J6dYdLTVV+wfSU4DY/trJ
 HJbgvHBVItVnP71fm91FVJBxyOcMuKQb60Yc84fLeVlSqUGzSiSFYLP4FCjUwAkndb8u
 kmboHWKZfcRfh5F0hgyUOfZ4tPBw/jmUt91Rss9UkDIe81m4fhFDLBKYnepOoLLoE1hQ
 HKQQ==
X-Gm-Message-State: AC+VfDztvCdgTANgh3+mLeAw50g47F02D/aJx2q9uqNsgJ3HD+sQtYWm
 dRTeVndwKiiC7+d80+NpTRRitA==
X-Google-Smtp-Source: ACHHUZ4skqtT8prQ+rLYLI14rH+2oYLy+xxwApLcOq0XFpggfwhZMVjuN54EsRqc4p1PBtvoz8Rtrg==
X-Received: by 2002:a17:907:72c5:b0:981:ca85:2c9c with SMTP id
 du5-20020a17090772c500b00981ca852c9cmr8775543ejc.9.1686730339178; 
 Wed, 14 Jun 2023 01:12:19 -0700 (PDT)
Received: from [192.168.200.206] (83.11.39.176.ipv4.supernova.orange.pl.
 [83.11.39.176]) by smtp.gmail.com with ESMTPSA id
 ha19-20020a170906a89300b0097d77a5f033sm6165037ejb.24.2023.06.14.01.12.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 01:12:18 -0700 (PDT)
Message-ID: <5e19d457-5658-edf4-855d-a8fc6dac5786@linaro.org>
Date: Wed, 14 Jun 2023 10:12:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Content-Language: pl-PL, en-GB, en-HK
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org, pbonzini@redhat.com
Cc: quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
References: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
 <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

W dniu 7.06.2023 o 04:33, Yuquan Wang pisze:
> The current sbsa-ref cannot use EHCI controller which is only
> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> Hence, this uses system bus XHCI to provide a usb controller with
> 64-bit DMA capablity instead of EHCI.
> 
> Signed-off-by: Yuquan Wang<wangyuquan1236@phytium.com.cn>

Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

