Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5497121CE
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:06:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SSg-0008Ry-SE; Fri, 26 May 2023 04:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q2SSe-0008RV-KM
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:06:08 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1q2SSc-0003j9-RV
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:06:08 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2af290cf9b7so4127701fa.3
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685088364; x=1687680364;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=yoQC3I2eU4wMZ8qhxPHsf12e+mtpn9CN/LIbOPrXsis=;
 b=yOxzGbz4yFnGeEkuS2UgwHSwnTtRJxL0nlVF8t/7LiQ4oQBtdsZoBON0UWaiSnmwIE
 m3QDqbN5zRnH1KH5OEk0W3aQcEaDnucDTA7Cx1GXYqhRSuh1XqpcE7NzIJusGXHPq0vl
 1BCLHO0cdTXiKjsksydjhkZccKKIqaHyCRDYPQ6ZB4PCSaRUGtLb/0ZT4MjHkc1NWlJW
 AIEowvPpWpsrl630BCUl0EWxjG2/V8UT3EnM9YwZsVqUnTPwWgx+UgsARER9uA/PmBTr
 O/tK/Nn2Wjv2gFNXa9SrALi6v/C/gYRLBnSqPRvKoxtYbSkWtj0vSCGTrAd4tfK9XcvM
 EWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685088364; x=1687680364;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoQC3I2eU4wMZ8qhxPHsf12e+mtpn9CN/LIbOPrXsis=;
 b=iWOn0VGni4u79c2G3IZCVxKf+nnWIRax96RVgDrH6ZrCrqd3NwYRZQCi2dh5DsJaxh
 GAetC9n6M3G19KhB+PMvJxCjWVqHI8p/rHu+QUXr9Tglo59rp8G+tNIGZ2As8Z4h62k3
 rzqa0hHQAJNpQ0LhOdp1XkjRfBoJDVR5KjUSGlu31bULHnrKPb2/YsL/DEPikm5Y+hFT
 3atvED2hZ0g3yCugBuqbiRJhU6FH344FeuhtIGjso+/RvVaXyX9Pjm3nCNVeys9+fV3S
 g3snMt9K+NEEMkVBqzS7F2Lg06btYLnqU3cU2hzsnAV6RRG3KeccLys8n7alxzzc7sEI
 Ir9g==
X-Gm-Message-State: AC+VfDwBWy/iieMI3dukQ7MCQ63B/Yhrh0iIIsjIdzpm0g5+1ajsLWgi
 gkl4qCh7yZjhEbeAw6+/6u1lWw==
X-Google-Smtp-Source: ACHHUZ6iwi67w7B5jfo27QKkHn5VIFb1yB5XX5aGrKyrCJam2Oz9HkVgb+eWPWS3PwX9k8lRIiW4xQ==
X-Received: by 2002:a2e:9510:0:b0:2af:2626:9f23 with SMTP id
 f16-20020a2e9510000000b002af26269f23mr418771ljh.12.1685088364242; 
 Fri, 26 May 2023 01:06:04 -0700 (PDT)
Received: from [192.168.88.29] (89-64-65-4.dynamic.chello.pl. [89.64.65.4])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a2e978e000000b002ad93c4c4e7sm602917lji.83.2023.05.26.01.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 01:06:03 -0700 (PDT)
Message-ID: <90397371-4ace-db8a-b2e6-0d1958ac6ca0@linaro.org>
Date: Fri, 26 May 2023 10:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/4] hw/arm/sbsa-ref: platform version 0.1
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>
References: <20230524113308.834675-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA8VxcdRvrRN2-pztriakGsXoGhaEcyptJ9z-0rPua0HGw@mail.gmail.com>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA8VxcdRvrRN2-pztriakGsXoGhaEcyptJ9z-0rPua0HGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

W dniu 25.05.2023 o 12:08, Peter Maydell pisze:
> The cover message subject says there should be 4 patches
> in this series, but there are only 3 listed here and
> only 3 emails arrived on list. Is there a missing patch?

I am sorry for mess - 4th patch turned out to be WIP one so I removed it.

