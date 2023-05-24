Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0996170F9AA
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:04:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1q1r-0007EI-2S; Wed, 24 May 2023 11:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q1l-0006ma-W6
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:03:50 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q1j-0007sU-HE
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:03:49 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f427118644so11963525e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940626; x=1687532626;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3mCJkaKVUyfsWnJ+UKM1NbNndW4jAHBbawP6IeKsjBU=;
 b=i0mv37k0Cp5Zhs5JJZ3mlrCrgSUCqpv7hwAfQd3kHbxUapveEs4bnSZTUIWZbxWsmb
 gGy3mwx68beqQ2NY+U5lpLHp1IGjG1nwgCOAa5sEoLmdkU24zzr7ODdgEgg8648VEM7+
 s5uwR1Oi5RtXYTX0C3N4kUsusPnFA+MY/sixvYOF89VVRGdzvh/Hsz8N7nWy85Nsez2e
 sxqkVGmVeRugATov4m/VyC+BvdmJEIXDvzIF72TxsJyWKHlBpZJSvR+KGiyQVayKjnkE
 CrMLF15hhDR1CebwI7jogVOQGYEUcVXj7so8y7ElU792xgZRvpZ3oFuacvm9jEpucDLN
 ylLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940626; x=1687532626;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3mCJkaKVUyfsWnJ+UKM1NbNndW4jAHBbawP6IeKsjBU=;
 b=dQ3uh+6Y/LZ9TaL3tHCw+eUjVBsnYSERJM/H6iUy95WjS092jI6GITCjRvWP1W6T+R
 9ulwSIBrMwNeR+z/eB+haByegwPdOc12k8lrInNSl4bulD+bPu1FJ8Tn2X8W9UIQ1ifm
 uvYfrOId/kq3BXff7QRVySd/rLjkeIgIJCgdmk4ZtuFjh3pRwndeZDhwmSZV0jUQzwlq
 RS+b7HM1BmgV6WnmdpkkhsW7uGohJ9zXt0NMMETLI6r4Z8wrm4aqQ9d6i46lMqz6wuFL
 lIAghYoyoi8Cf3caixgoTslZp+fMyGUpOSYieBxsw6PeolqbLbIQfjBxtIKiClZzGYoN
 GIRA==
X-Gm-Message-State: AC+VfDz0VoAcLkL9ch197Kym8jGrOGv4s4b15UPZKEARI+OsimIKWc7m
 4uGpSCiLPZaR8i9lqjTLQ//sHQ==
X-Google-Smtp-Source: ACHHUZ4055B3g1WasRi8I8a7hT177kqWtAcerv1SVggRCUycjWquPyHqVIlR2GAOfiRGkSIiqXcgfA==
X-Received: by 2002:a1c:7307:0:b0:3f6:3ad:16a with SMTP id
 d7-20020a1c7307000000b003f603ad016amr39553wmb.31.1684940625849; 
 Wed, 24 May 2023 08:03:45 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n11-20020a7bcbcb000000b003f5ffba9ae1sm2622210wmi.24.2023.05.24.08.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:03:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 312861FFBB;
 Wed, 24 May 2023 16:03:45 +0100 (BST)
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-7-philmd@linaro.org>
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
Subject: Re: [PATCH v2 06/10] hw/virtio/virtio-mem: Use qemu_ram_get_fd()
 helper
Date: Wed, 24 May 2023 16:03:40 +0100
In-reply-to: <20230524093744.88442-7-philmd@linaro.org>
Message-ID: <87y1ldvkj2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Avoid accessing RAMBlock internals, use the provided
> qemu_ram_get_fd() getter to get the file descriptor.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

