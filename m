Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7A17CBCD8
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 09:54:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsets-0008RD-5g; Tue, 17 Oct 2023 03:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qsetp-0008Qu-Q7
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:53:57 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <viresh.kumar@linaro.org>)
 id 1qseto-0006rR-5t
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 03:53:57 -0400
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6c64c2c0f97so3230593a34.3
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 00:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697529235; x=1698134035; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=76TCzZD1Wmz8LnBDcXuJr04/SVVH2Eru8krA81gMwnM=;
 b=fBgwmBfOIwbuvqrJl+tJUSZy4FJNtmJ/LzZqsdQHSjEZx/vFviS1c44r0V5T99A4AX
 c6OX0d8xG273c1ZQkqP2d/Xs5Holg0F44h0U9BVLz+11EAsjUrD3IUN5Gmu0r7M4gnZh
 wHv9iL1YVk+5dTTOaae++op0tz5STTwdhOxsDNok8VApeQGMI1KOIMtfYpWteBCAjF9h
 Aq3ozpJa7pQ69dAZTdVniUBdQSQyCXBVAGZVstBUrUuxbleuKD/SAZek1OwE7PLN6Q+x
 Tl/IJ/XCsSO3Fiy3fHeNmGBmdLLylnIIRphzx7EkitLv8cN7ZNiFkTF2ShkDhkLxh7ih
 VNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697529235; x=1698134035;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=76TCzZD1Wmz8LnBDcXuJr04/SVVH2Eru8krA81gMwnM=;
 b=lMsXfnx3oZOfSGyOBwZ+Fwlg3x3zB4NgGLwwd5tKC6lJejejPGgNFujELgAdKklNBe
 htbUaSMDJ1DZYTvpoMRpW9Pzkay5byEgU6dQVDhENw6uJjDyWsml1MhACDt7N4n0oElY
 7u60BKnGOgbd7y2D0VMZO9+eW9Nvf6xiGqnEFWvfpTIq/VRvlRrTPmyGMhnqXcKjhsgD
 dDFIRhYVO4a9qNFqRlxy8FfDT1eIAEbr13BrkBXeNhuWi4meKTSLmqL5dY7zPtPoxtsb
 mx6qsck0rXI4798+/KTs4MtyDnNsm6iXnyCnvVPrpV1Z21+2hM5myA0tnK/1XEZ5jTCb
 2DIA==
X-Gm-Message-State: AOJu0YzccVUi/JWjYI3M8zvjovrHD3AZtAZX9qYVTr0dqR3PollU5Q+F
 WUBs0NmXNDiEjkHxZy26pyafOA==
X-Google-Smtp-Source: AGHT+IEWUWItDDrc1q4qQMumPPTnb07oKXnGz4eXULxIYQ2rDEnlNeQ7xDa8s8Iy02TB9Zti6HvImA==
X-Received: by 2002:a9d:6858:0:b0:6bc:bd1a:26d with SMTP id
 c24-20020a9d6858000000b006bcbd1a026dmr1520736oto.15.1697529234896; 
 Tue, 17 Oct 2023 00:53:54 -0700 (PDT)
Received: from localhost ([122.172.80.14]) by smtp.gmail.com with ESMTPSA id
 f11-20020a056a00228b00b0068feb378b89sm804636pfe.171.2023.10.17.00.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 00:53:54 -0700 (PDT)
Date: Tue, 17 Oct 2023 13:23:52 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Albert Esteve <aesteve@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Garhwal, Vikram" <vikram.garhwal@amd.com>
Subject: Re: [PATCH] vhost-user: Fix protocol feature bit conflict
Message-ID: <20231017075352.2l3htkj46gunyjrm@vireshk-i7>
References: <20231016083201.23736-1-hreitz@redhat.com>
 <2m60m.9e9wlnnm01vd@linaro.org>
 <20231016103254.7xrnptmwrjnsr3uc@vireshk-i7>
 <87lec2dc7r.fsf@linaro.org>
 <20231017053638.hhs57axmwqtzbpp6@vireshk-i7>
 <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ceeaa1f3-c0ad-65c1-80d1-ec869f976146@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=viresh.kumar@linaro.org; helo=mail-ot1-x32d.google.com
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

On 17-10-23, 09:51, Hanna Czenczek wrote:
> Not that I’m really opposed to that, but I don’t see the problem with just
> doing that in the same work that makes qemu actually use this flag, exactly
> because it’s just a -1/+1 change.
> 
> I can send a v2, but should I do the same for libvhost-user and define the
> flag there?  Do I have to add a patch to do the same for F_STATUS, which so
> far only got a placeholder comment?

Sure, that's fine too.

-- 
viresh

