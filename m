Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B19578D12F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 02:38:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb9Cp-0003LW-Iu; Tue, 29 Aug 2023 20:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qb9Cg-0003LB-EL
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 20:37:02 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qb9Cd-0007Ps-S7
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 20:37:01 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68c0d4cc3a4so3053808b3a.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 17:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1693355818; x=1693960618;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XwP86mLflDpC2mbatMG6yPFlEAiAWAhOVGKe+iQCU7k=;
 b=Gdlu7QKdjy0OTPpLT7JEWG66rk/1dFHKJjxlz7zAmBhZHQinIQ74is8UTiU10UO9da
 c5sontGLeSg4OD8SGweMMW9pkunlCadC0jqXvvC1VbMehpWWqqWt0niZKE0K55ZdAO8H
 9ioupBuuS9vxuUdTMEyq64jo4xhFRMI9dtjgDwNHYwHxQwKiDbagdnY7Ohl8Vu0OVVzF
 DzgysE9E84dXa7JL84uXq8TcMGgtw5maNr3Lnq4aKSer/uxw+gMk95ylPv7f63f4JoZk
 anrz7xkjSEqczfPC5wm/WIq50z3nY1sy+H2txGZbHSW2SYBG/IUysq7OrJmRUJxJNl/F
 ho/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693355818; x=1693960618;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XwP86mLflDpC2mbatMG6yPFlEAiAWAhOVGKe+iQCU7k=;
 b=HoZqP6ilS4R0oTl+A3VC9O9/GeSnzfpr7rZel8hNNHcXo5+YOzkfMqMEEUUrh4Brem
 3PUNd41WePnQ4WtonJBtaUulDT6OIoxceEoYG3Py5nJqxCUcxBzqBH0Ieuo6811vs0ug
 C4nZJUc14x8ofqNuiR1RfiOeou2Y0eFLMsVgil1/ymeN4OMSw/WfCJb9l1nXk2e5jRun
 GyFSyyD9XX3wC70aansmfaCeXH+UD4hS+cxNwTJYlBAgWKaiUbwY+uLS/zu8cTYHh31A
 eLFm4ywhD+85/RwFpofxAeNxQVvfeVIrnMO7W3AWanqL7tBlckzAtTp+kXkeNuesP6Gs
 vv/w==
X-Gm-Message-State: AOJu0YwbarRDyE/LpHh1De4l5CaLzbXvC8yA6NvfW4/qvnNVy7MUN9aV
 EfU7Q2k4eT8M76yylXnIvxkuEg==
X-Google-Smtp-Source: AGHT+IE66e9RfvPaoCXYovdahoQoh7asuFW8RYzPtzz6kQT985xGLGuoM8tBCUJODFR1AYT8Uusreg==
X-Received: by 2002:a05:6a20:5498:b0:14c:c9f6:d657 with SMTP id
 i24-20020a056a20549800b0014cc9f6d657mr1037116pzk.22.1693355817782; 
 Tue, 29 Aug 2023 17:36:57 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 19-20020a170902c11300b001bba3a4888bsm9957541pli.102.2023.08.29.17.36.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 17:36:56 -0700 (PDT)
Message-ID: <831e7072-be8f-4e68-80c8-f1fccbbccfd4@daynix.com>
Date: Wed, 30 Aug 2023 09:36:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] igb: Add a VF reset handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
References: <20230829090529.184438-1-clg@kaod.org>
 <20230829090529.184438-2-clg@kaod.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230829090529.184438-2-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/08/29 18:05, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@redhat.com>
> 
> Export the igb_vf_reset() helper routine from the PF model to let the
> IGBVF model implement its own device reset.
> 
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Suggested-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

