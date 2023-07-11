Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2511674EB7A
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 12:08:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJAHO-0007uF-It; Tue, 11 Jul 2023 06:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJAHM-0007tz-K3
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 06:07:32 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJAHK-0001Fq-Uz
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 06:07:32 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3159d75606dso1809930f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689070049; x=1691662049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ProW7ZLOMnZTL3wZA46Kylr7IyNc5XznCQEwseepnFA=;
 b=KnMrTZBIyQYsknEAsLobE6mAPBxhYjDiwGxo8kng/g55a0sI3mFKaEFG4Glk7Mcm+/
 IdcTWveUMDf98J21+fuycwoIUybzJk8dlNxAq+rPSnaYCOuTaZplX+xtQqdGAyztdvi3
 0cv/gpEvmjsMpe1RT0iF0UAo8WZ4DFmk+6GglweHcQuGwuZQayJAmynlhzjnkqFUIksS
 dOWuEV7fuDYv5ts8AcHKeah7pDQVW9YEddW08lllpQAaFM/Jg0QGqdMiQ8ac9CtwVuZ8
 sMMwaOUSkLiaPpzuRtFX2j3fNXt16cejgCsdBaZqP7us8NS3FJRJzpmlLtRi3+nApiQf
 XlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689070049; x=1691662049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ProW7ZLOMnZTL3wZA46Kylr7IyNc5XznCQEwseepnFA=;
 b=lTuZT15hhnr+RLzDGZvrYvPXqPYlvl67666jWcrB+UCLDejriDoSI5/fapZqKCxtOH
 lnfYnCKiwFKo6ag5YPuBR8L+xumXT9mpKw3rTreW/GQHIveECqgXb8ldJXoFSwlDSWGy
 aEs4WheBIq93vTg+uItFWDf/uXUfdg3S5PvmTWe8hLlyVpf9Nx3vyt7pxSgux98yAOB0
 xlUc0wCyUDwo8HtSq4w2S3H4p33JB8ayiCOqkr1XellVXmQ5vHqgt1u/NLQt3yEZursT
 3q0EEdW6kofvlqQMKqO35qD/0XQGuh9dtl16mFpQ//HX2lRYNiG6Jo9eXegRKe4jW8+9
 wKgQ==
X-Gm-Message-State: ABy/qLZgpunXalAJ1wx0+pg+B8k6iZNnFL/PJMCug0OEeKSWVYSsasNu
 FF1P9lCpQX8Xssgiwr3FLNrRNw==
X-Google-Smtp-Source: APBJJlGN7SIEPc3HCzGOM65+ac90l2pmmPLAfMXzf5MXLQHBcTmhchj2eHR+rqAPbog575W0FkOqZw==
X-Received: by 2002:a5d:6d4b:0:b0:313:f54a:a83b with SMTP id
 k11-20020a5d6d4b000000b00313f54aa83bmr13177994wri.59.1689070049425; 
 Tue, 11 Jul 2023 03:07:29 -0700 (PDT)
Received: from [192.168.8.133] ([85.255.236.57])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a5d46cc000000b0031455482d1fsm1825120wrs.47.2023.07.11.03.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 03:07:28 -0700 (PDT)
Message-ID: <12c49b2f-fb6e-d17b-db21-4a1faa70f94f@linaro.org>
Date: Tue, 11 Jul 2023 11:07:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/66] pc,pci,virtio: cleanups, fixes, features
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <cover.1689030052.git.mst@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/11/23 00:02, Michael S. Tsirkin wrote:
> The following changes since commit fcb237e64f9d026c03d635579c7b288d0008a6e5:
> 
>    Merge tag 'pull-vfio-20230710' ofhttps://github.com/legoater/qemu  into staging (2023-07-10 09:17:06 +0100)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git  tags/for_upstream
> 
> for you to fetch changes up to d669b7bba22d45cb9e5926d63541e52bde1655dd:
> 
>    vdpa: Allow VIRTIO_NET_F_CTRL_RX_EXTRA in SVQ (2023-07-10 18:59:32 -0400)
> 
> ----------------------------------------------------------------
> pc,pci,virtio: cleanups, fixes, features
> 
> vhost-user-gpu: edid
> vhost-user-scmi device
> vhost-vdpa: _F_CTRL_RX and _F_CTRL_RX_EXTRA support for svq
> 
> cleanups, fixes all over the place.
> 
> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
> 
> ----------

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


