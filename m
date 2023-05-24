Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 972D370F9A9
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:04:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1q1M-0005zl-7u; Wed, 24 May 2023 11:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q0s-0005n4-Jg
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:03:05 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q0n-0007VL-So
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:02:54 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f6094cb2d2so12472565e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940567; x=1687532567;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wjh5zBnxragQSB77PUkEgmpbizQ8otcTeYRxUaSAAA4=;
 b=IZnPlXwd87/3CI8qasgfTcY7psACc6kJpAM8dbUkLRJth6+6L3wGBSYfqeH/CyHQLB
 oFxlSXkYUBg7D60Ci70KvmEXuqcyi3eoCVZO79V2BR+qcYE29AQ/ZCoApjFvMbSEUg+0
 KCPw5Ihwr8zj4d/419zy6pIEl0dlo2Iypp4GtgttKD5LGdQbxRdoVeJt8eaBMHrdUdWX
 z3T8lywp1xRgznvrPhAYrIXrYqnT4ux7xWIfto+3yUcUXcb39s6mTc2XjUy4P3oGptLy
 CRyrdzmisRhE/NHD0k9UjKAawdF3ZjyvDNCOA0OBDM/1T1WFFZha5kE/wVORRZWH1vqy
 z57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940567; x=1687532567;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wjh5zBnxragQSB77PUkEgmpbizQ8otcTeYRxUaSAAA4=;
 b=UndYiuW6kCcVHMI72BdoNpOVfkddYq1IaKHQZlailbHi50ltTFLxbuxcpHCU/FwHu6
 /AdjErT5b7GUmLfBhl6CNnTgstptvcar8vBvluLjear0gn4rUbhMEJ20czssTsar8lKd
 a8jmvzLbFQfk9FDBULZVofjt9JOpT1rG32t4gWoHTL/i2inoVbDnt9wccTNbFieZoQPL
 70f2TWi8l+x2d59ADBnQcxnS2eJ1cQMX4Wcudv46S0nbx0PWPIO7ypbzHopkvAOy/pr3
 uKW/jLGYzP7ERn9hYy8vqFXIIAxM4iJUbUuMFRRFxTAMLFzC1UZOFsLuo0f+UdSO4fpL
 3QRA==
X-Gm-Message-State: AC+VfDyvUIOUFKldcKKf0tDAVRboezPU5kZ3B/XJmCyKiYlcOUOXMOJZ
 B+PfAS90UMZK/e7HXVAQcWz5Fg==
X-Google-Smtp-Source: ACHHUZ5HQRnhKDfXNYjzrey2VSpOt4lbuwdww7ORsw1vkH+mp4AoDupNVVKhQBy0r5XMpkIz6pvHhg==
X-Received: by 2002:a1c:e901:0:b0:3f6:490:a7f3 with SMTP id
 q1-20020a1ce901000000b003f60490a7f3mr70655wmc.9.1684940566745; 
 Wed, 24 May 2023 08:02:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a7bcd0d000000b003f60d0eef36sm2606199wmj.48.2023.05.24.08.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:02:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 217E41FFBB;
 Wed, 24 May 2023 16:02:46 +0100 (BST)
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-3-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>, Peter
 Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Raphael Norwitz <raphael.norwitz@nutanix.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eric Auger <eric.auger@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, David Hildenbrand
 <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic
 <pasic@linux.ibm.com>, qemu-block@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/10] hw/scsi: Introduce VHOST_SCSI_COMMON symbol in
 Kconfig
Date: Wed, 24 May 2023 16:02:40 +0100
In-reply-to: <20230524093744.88442-3-philmd@linaro.org>
Message-ID: <877csxwz55.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Instead of adding 'vhost-scsi-common.c' twice (for VHOST_SCSI and
> VHOST_USER_SCSI), have it depend on VHOST_SCSI_COMMON, selected by
> both symbols.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

