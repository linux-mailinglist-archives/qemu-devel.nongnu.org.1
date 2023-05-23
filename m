Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDBC70E95F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:08:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1b76-0004GZ-T0; Tue, 23 May 2023 19:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1b75-0004Fo-8o
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:08:19 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1b73-00048m-M4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:08:19 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-64d1a0d640cso78398b3a.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684883296; x=1687475296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=agWRIHU9XDYYlngosvlI3QCegPFWYfLdC9lyTEPdwcY=;
 b=SG3GdkHokaYFNuno9xUchjeq68BaAruxB2GxB81IWskGZ8+z5o7v08tUN4bVnvr0Io
 CTaci8sICorCywsRxXZptEp+cOZyQnmJWBn/eSHoUrE//CjaXN9gD4vz6TWKR1WdL9ej
 EUJlslZGey/Mlm/10gQQoU7RptoXT4x8FZ3KPeC7VCbEO3Rz7PBFQveFeY9OQ4ZMZYSX
 e82nkKPcvBwe8qql74PM4piuOdl83lwBlBOewGtw1ROIYr65rqUCn6ysbSAsl0760PWJ
 aT5oNx5AqNKGW8K2TutzTIloN0BvlPfv34NJeAn+KTk/K0c9cGxEYpPAeindgIVSaEL9
 aSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684883296; x=1687475296;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=agWRIHU9XDYYlngosvlI3QCegPFWYfLdC9lyTEPdwcY=;
 b=eLba33bZ++4XByJEC8jm33YNeI2k94oZqF/JCqoLlbK39awu8KQhnWx31fN1dHYrLf
 NrddbN4y1mA/gUdAIdAslNGrUbtE0P6euCm/Kl2DEiehl4qvaCq/1nS3LcXYU7IJ45u1
 9M47zOY+m3OSR6jkaFTrdP5+ZLEmcfJJV1O5MGgcqr4fVrlqSIiV3uldbMzYibYXjeNJ
 61tR0c5N3xAvQTBFMvsclZN7kExtfqfKziDXNVNhjntxP+HD2X9VzMZAdglJ9R6OhI1s
 NzKfj25ZhptTOJSDLKT5ioByi2rOgEjQ3skOU/0M9vIxdY1rr4CwCory7o8PU5bvHajp
 xmfA==
X-Gm-Message-State: AC+VfDwBRzAn53P+g5ZhywZ28UT3E3tf03eUcPs7+odwz96PuOr0hvJI
 gigR93f/J19KTM7mroCx0TWThw==
X-Google-Smtp-Source: ACHHUZ6qAJsKZgY5f/4ptugzbBwZoeDgRQFdKKa0bhFuRf/0m6d9+WEE8zGfcrhDTqLVUNC+/ZRZcg==
X-Received: by 2002:a17:902:db03:b0:1ac:712d:2049 with SMTP id
 m3-20020a170902db0300b001ac712d2049mr18702374plx.6.1684883296088; 
 Tue, 23 May 2023 16:08:16 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a170903201300b001add2ba4459sm7287588pla.32.2023.05.23.16.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:08:15 -0700 (PDT)
Message-ID: <078396c4-b86c-3b46-63e1-a62e88e814eb@linaro.org>
Date: Tue, 23 May 2023 16:08:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 01/11] softmmu: Introduce
 qemu_target_page_mask/qemu_target_page_align helpers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Peter Xu <peterx@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 David Hildenbrand <david@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Eric Farman <farman@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-s390x@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> +unsigned qemu_target_page_mask(void);

Should be signed int, so that it sign-extends to whatever needed width.

r~

