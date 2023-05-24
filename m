Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DD370F9BD
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:06:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1q3n-0004ID-58; Wed, 24 May 2023 11:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q3k-0004A5-LK
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:05:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q3j-0000Dk-0p
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:05:52 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3093a6311dcso958081f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940749; x=1687532749;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z9CvNsTtQdxkOXdMdubAiXXIRPdDL4RJ5St08ONRakA=;
 b=p5q3/adPxkTToInOJ8vbsRh0LiJgeNY0EMkssFvfrl4yz/aZXmfAfgb+QgIcHcZVE4
 HsWkoeZHjS4Ahcjbw0cZI1f3URebVY7/58kMjgogJxQCt0Blfj2r54L7nDobJlpggJdz
 JhcxKICt+950Kq0y+XclmKWASIPIVDVETNt0GGf+Yw4XgAbSC0uhQOE1DsVW4rsV6Mb1
 I+n6f1d5Mmvp8ElO7NkZ3ZEk4DwHngbykOwZsqM1gDuXzlmPChqYgI4WTByHb7lUc0YY
 eNoISf3ooiYnWwwyWiY247DoDi50NGemRx+bpRfBrAPG43Nd9gOg4nui5c3zEo0YuY7Y
 q+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940749; x=1687532749;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z9CvNsTtQdxkOXdMdubAiXXIRPdDL4RJ5St08ONRakA=;
 b=Xqxkqu5W9/JHB0FQrDKjiNql5Wjhs7geNRbC4pG/UEsqRdVjagMqHHSio/WGLFeqk1
 4qqI/68oyHy2jwSOJgYK56tIQZxXdtwmoLGfzy8bPBVZCGbUnyrxGIoRawog43MOudiG
 MpL91lOpnMRwZWtXLnlW4wsHIobD1XRCh01kcl4UQ88ckGcnTvKXQrvGhZFwHvUFuUNV
 z9QGk7bOloFsEdH7xpqbAuIQ6jB9/+TpJqqR/wDIeAVyVSLRoeVwz5r7fPJUnvomWnVW
 1tbVfsHMNZwpwb7/b7yBWBcAALSBicyBpWG0ha5faN/20uUthwntQkUUw5m0RvdHEbqE
 R8bQ==
X-Gm-Message-State: AC+VfDy2NgKP9H+gb2xbMbm6P2YXeGGDKvnxB/Jk5Z0sz5g+gq1Bp05y
 Zwcj/dTQIQmnvF33wjeSV3p9jA==
X-Google-Smtp-Source: ACHHUZ4sLOMlqyP3J1EbTQ0laFroTNrvh8ACZdKJk0MZLSEsRdVSEk+9/WWFBZoYzst0MG5QhZnNWA==
X-Received: by 2002:adf:dd89:0:b0:304:79c1:725d with SMTP id
 x9-20020adfdd89000000b0030479c1725dmr68459wrl.45.1684940749156; 
 Wed, 24 May 2023 08:05:49 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 k2-20020adfd842000000b0030647449730sm14768620wrl.74.2023.05.24.08.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:05:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 748DE1FFBB;
 Wed, 24 May 2023 16:05:48 +0100 (BST)
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-10-philmd@linaro.org>
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
Subject: Re: [PATCH v2 09/10] hw/virtio: Remove unnecessary
 'virtio-access.h' header
Date: Wed, 24 May 2023 16:05:43 +0100
In-reply-to: <20230524093744.88442-10-philmd@linaro.org>
Message-ID: <87lehdvkfn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

> None of these files use the VirtIO Load/Store API declared
> by "hw/virtio/virtio-access.h". This header probably crept
> in via copy/pasting, remove it.
>
> Note, "virtio-access.h" is target-specific, so any file
> including it also become tainted as target-specific.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Acked-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

