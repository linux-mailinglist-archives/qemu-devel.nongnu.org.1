Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F1D7843F6
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 16:24:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYSIW-0005cZ-8x; Tue, 22 Aug 2023 10:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYSIT-0005bz-PO
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:23:53 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYSIR-0007nY-Lb
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 10:23:53 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-99bf1f632b8so611301766b.1
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692714230; x=1693319030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7TWQweYACCuU8OjNZMwPADtKhWYBvtXsbmznGbvy6E0=;
 b=vhJc8EIZ5QUZyWwO/jQ7rN6V7j2IqHh1xRzh8kmmizQHHLyCFhjo2XjOE9FJhMEwwy
 M4tDL1Hy/NmFU6NThal9ZTLaSYZn/MEQgDAd54fyousf+rog6y4cx92fDsJPNwTFlNtC
 q4JpnT0QGCgoB9J2Ek9XBpTw/oUAKGuKWNreHsst5gsMoWHvBhiNuRIMsoQt9Uoh6ZrW
 9PwLk11U0BH/bLQJ71v/UrdHCSBKkqVtHW53j4bUUOw2m0wMWXwERAhwvMoRrr2hVpPW
 tSYWlHfWgcMZIVO+oi1f3/U8A1YfmAdi5ed6cQgVOS5vCSAQQsbCkMKB3v9SPHFJndVy
 sVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692714230; x=1693319030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7TWQweYACCuU8OjNZMwPADtKhWYBvtXsbmznGbvy6E0=;
 b=g5wf3yt0fm0GEDKNmhOHaSofHoB6gHzT623ajoSlVOS1UkjCb7EqfPecfgWDdzQ3NB
 d6gMyWqgBYbxr5fx5J11UwcEe4PVhRKsu+ykYYOsl3tPXyf0h3YSKGjZvwuH9oewkUsR
 mM5Dw5QjqEqWimweIf+YeUM9OeiNeiFkyEMtGnT8/LKGziIksAi1C1VqnEblx6tI/LIg
 wj3rZGufZj8KKECp9aE3bBYH5+zdCRpRIZm0gRbNy59pn16XGkNNdLrN/rucEowezAMQ
 q8gHSINIbdzGe39yuK8d+wW4DALQaucxTkXyXWBPgZ604nIKqeg6zHypEBY/3/gRFVgu
 nfPA==
X-Gm-Message-State: AOJu0YyWZXkXE/eIoNzY30KP6IKcCibv9bGSsbaHQ2V5kgEshoFxdi9F
 E6j3PetZfVQqcjdKzABiHElANiSU/YR4v05IR04WmA==
X-Google-Smtp-Source: AGHT+IGe5caGq/jMVDRm7W8i3kdOUwn5kbZVFaM7eaDJvHhusZYvcqCf9p1rL6sBL2wiFsjfnNVk21xdv3rcE5fjgoY=
X-Received: by 2002:aa7:d481:0:b0:525:7da6:be26 with SMTP id
 b1-20020aa7d481000000b005257da6be26mr8227857edr.28.1692714230119; Tue, 22 Aug
 2023 07:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230822114504.239505-1-david@redhat.com>
 <20230822114504.239505-10-david@redhat.com>
In-Reply-To: <20230822114504.239505-10-david@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2023 15:23:38 +0100
Message-ID: <CAFEAcA9HxpO7Zzh4VA+9d8dZuc-zP9SmFDPk6-qQzBAJBsoJ3g@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] docs: Start documenting VM templating
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Thiner Logoer <logoerthiner1@163.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, 
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, 
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Tue, 22 Aug 2023 at 12:49, David Hildenbrand <david@redhat.com> wrote:
>
> Let's add some details about VM templating, focusing on the VM memory
> configuration only.
>
> There is much more to VM templating (VM state? block devices?), but I leave
> that as future work.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  docs/vm-templating.txt | 109 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 docs/vm-templating.txt

No new .txt files in docs/, please. Use rst, and incorporate
the information into the correct parts of the manual structure.

thanks
-- PMM

