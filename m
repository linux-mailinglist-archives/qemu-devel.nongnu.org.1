Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE7C70F9AC
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1q1o-0006st-NE; Wed, 24 May 2023 11:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q11-0005pr-4k
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:03:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1q0y-0007Yp-T9
 for qemu-devel@nongnu.org; Wed, 24 May 2023 11:03:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3f601c57d8dso9923415e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940579; x=1687532579;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPQ0VkutHV8EHafPz61aGrOnsHkaoQUm7tZq83rnSHI=;
 b=Izn6+6MNgLD57f9v3CYJbf3vID2a1HpVN8849PmJPuoaxwo5K9fmu539Sl+UPcmNsl
 0lAJiQyl2KcnEVAKjb0qmIJkTb9sqjw3QBpUDoOCWbx3RlnJscyvs5qsqoEVVnU+O/Dc
 iZwc+kjJhQVvRwA1vlKt2jXpvmgBmvXMGHu8GP0v11SdVx2wxiZyyulE6YbT2TWAy9m5
 kaQ7D8EallcsqgXzSNuZHs7XKEerQfLyyBLruc3lkzFewm9PcXRTeY7QySkBvVp79V71
 9KgEejT39JXny3taOROlAyJ5kZkeuuKnJeEB0QN+gYzCNcDDsVSGxCY1RKm/rL7V3ygp
 lAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940579; x=1687532579;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GPQ0VkutHV8EHafPz61aGrOnsHkaoQUm7tZq83rnSHI=;
 b=EHquJkVMAQIqH2zyRDYyvYvCrrwqYFcVazw/eeCuhWjYaZXwRfXhjmpuJFAXy1tGJL
 /7EXBaWXkgUx+RUUZLCEhjhYPboD/p/FCDvjWGcpKBmJdszWAqQwp8F4wenvz/kavzBR
 2Tc+nN92CWXHC8OzmzsGuqCjUInBREMqau2+KyaCcV8ey2cklNHWApR6FBTWobK/n4z7
 jd39isbvHZuHQ5sRkN9X1mi9uFzV4xI38wE480IUQc6GvGP+88kGSP/0jAzCa784kkAl
 +BVucJPM16risb5RnfNuJOQjrz7Z2u49ewZtAaVmY96qnJbHRgjjIj6J7h+hmNBwvFjG
 Y/mw==
X-Gm-Message-State: AC+VfDzzddOMpeGCHs3WUrL6xwyGRnFnc+wPkRObPN9jv2DUAoyvfnm0
 UUQJ2+++M4gxUXKZwqmwNUfuuA==
X-Google-Smtp-Source: ACHHUZ4Muyqf2ZbSho4WFBPCF9dU07Asr7l6bhs0uhIy9gIEa7b24GhauRm5loo74G7H7THz/DzgbA==
X-Received: by 2002:a05:600c:54e6:b0:3f6:335:d8f0 with SMTP id
 jb6-20020a05600c54e600b003f60335d8f0mr22148wmb.13.1684940579483; 
 Wed, 24 May 2023 08:02:59 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c021800b003f080b2f9f4sm2582336wmi.27.2023.05.24.08.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 08:02:59 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CAE121FFBB;
 Wed, 24 May 2023 16:02:58 +0100 (BST)
References: <20230524093744.88442-1-philmd@linaro.org>
 <20230524093744.88442-6-philmd@linaro.org>
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
Subject: Re: [PATCH v2 05/10] hw/virtio: Introduce VHOST_VSOCK_COMMON symbol
 in Kconfig
Date: Wed, 24 May 2023 16:02:54 +0100
In-reply-to: <20230524093744.88442-6-philmd@linaro.org>
Message-ID: <87353lwz4t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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

> Instead of adding 'vhost-vsock-common.c' twice (for VHOST_VSOCK
> and VHOST_USER_VSOCK), have it depend on VHOST_VSOCK_COMMON,
> selected by both symbols.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

