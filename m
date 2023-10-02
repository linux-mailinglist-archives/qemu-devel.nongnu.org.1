Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB857B5D7B
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 01:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnRtV-0005XX-SB; Mon, 02 Oct 2023 19:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnRtJ-0005VR-O8
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qnRtI-0003sE-CV
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 18:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696287591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWilonieimI1dctfCo5+uvvWHb07ew0SZJtvKNU/Rr0=;
 b=ZmAKpi+HRTTtt8ojYlcG8h88gkRqmlrA5bOYHqQ9zXIFWm4qGx55MX6rk62FQbc/GiRupz
 T7MgvAAXyG0fJKU+gooptV33QnTN46WoxM9O6BywBWJ99xBTxk/Pho8Wnj/sdPkZluMUsL
 5oIhJmmL9AH0nKYqRPz7t7rcxDdDgPk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-K96G2Dv-MNipvENCYN_aKA-1; Mon, 02 Oct 2023 18:59:29 -0400
X-MC-Unique: K96G2Dv-MNipvENCYN_aKA-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3af6cd0146dso466961b6e.2
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 15:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696287569; x=1696892369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wWilonieimI1dctfCo5+uvvWHb07ew0SZJtvKNU/Rr0=;
 b=p8Of7jaxeK6RidNQqB8yH0lCIzLtX5NwVNrI19KNgFaNLor8SnMe7oZL56rt6+WvJW
 zc30n3vYTrV61chyR+7NUDffZVPP6/m26XyVAi7tdj622UGI8BStFQnXFBFNg/UeTKdQ
 wjGqtr0dCftbJkJ6SrxvgJjjFn+e0ZGmYeLiufilHneIMSEPtjsYITUPUBG6opvMqCql
 t4+mLG1batX5DWNCbtEQQ0ussOvnUheMWXdwuhPSQRp7NuYfXV/VZ0XCInGG6CjbeJEn
 sagihQQmaAzR/65OgHkfefMbGCB/T2vIA7OeKoFILGcwfNZyySLQPjQyp46hSxQLVVGc
 PnsA==
X-Gm-Message-State: AOJu0YyFrZviu2DV7LCci/yz4yjejcCSk5srqZFg082FiMTJffRiRKB4
 1UqiQps6rS6EpOJ/sdFeqA8//92j1NZmIVq6NiwgfPjZvY7d2OQSQhKcTYTXbeZbO7JIMsCzqNp
 AoWtLuxAA8VB+DEx4xzEwMRQSMPVCQ7s=
X-Received: by 2002:a05:6808:3c2:b0:3a7:2690:94d5 with SMTP id
 o2-20020a05680803c200b003a7269094d5mr13188456oie.8.1696287568932; 
 Mon, 02 Oct 2023 15:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0rO96erv7wNy/Qb5/1YsJmxrCXuWF9XtQ5X3Jp/WDOEr9b3gNNIPF5JNTkaVfkx9OaW0QvAVn6iRFQFd2oHI=
X-Received: by 2002:a05:6808:3c2:b0:3a7:2690:94d5 with SMTP id
 o2-20020a05680803c200b003a7269094d5mr13188445oie.8.1696287568620; Mon, 02 Oct
 2023 15:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230921160712.99521-1-simon.rowe@nutanix.com>
 <20230921160712.99521-2-simon.rowe@nutanix.com>
 <CAFn=p-YL_hmnrFY9hhuMgMkV4hL3dojMMWUdG9=DBGYuxi_TUw@mail.gmail.com>
 <7658d927-1d05-8f2d-9739-d1db692bee72@proxmox.com>
 <CAFn=p-YkEJajV_YuOsK4KPL6T1erEhdkameN-XEEXrwY+XZZ6g@mail.gmail.com>
 <4a1a5f8a-6797-104b-4a91-b5fa24607fb4@proxmox.com>
 <DM8PR02MB81217871CAB18CCBB04938F893C5A@DM8PR02MB8121.namprd02.prod.outlook.com>
In-Reply-To: <DM8PR02MB81217871CAB18CCBB04938F893C5A@DM8PR02MB8121.namprd02.prod.outlook.com>
From: John Snow <jsnow@redhat.com>
Date: Mon, 2 Oct 2023 18:59:17 -0400
Message-ID: <CAFn=p-a7UsM=dmJjmLpKmd1WYgNnfxQR1AsOQtCR64uZwVYZeA@mail.gmail.com>
Subject: Re: [PATCH 1/1] hw/ide/core: terminate in-flight DMA on IDE bus reset
To: Simon Rowe <simon.rowe@nutanix.com>
Cc: Fiona Ebner <f.ebner@proxmox.com>, Niklas Cassel <niklas.cassel@wdc.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>, 
 Felipe Franciosi <felipe@nutanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 2, 2023 at 5:09=E2=80=AFAM Simon Rowe <simon.rowe@nutanix.com> =
wrote:
>
> On Thursday, 28 September 2023 Fiona Ebner <f.ebner@proxmox.com> wrote:
>
>
>
> > AFAICT, yes, because the DMA callback is invoked before resetting the
> > state now. But not 100% sure if it can't be triggered in some other way=
,
> > maybe Simon knows more? I don't have a reproducer for the CVE either,
> > but the second patch after the one linked above adds a qtest for the
> > reset scenario.
>
>
>
> I initially tested an identical change and, yes, it did seem to address t=
he issue. I preferred my final solution because it felt wrong for the DMA t=
o continue after the point the VM is expecting the controller to be reset. =
I felt it was best to leave the ordering as is (because there are multiple =
other controllers that use ide_bus_reset()) and terminate the DMA transacti=
on using state that indicates a reset is being performed.

Which reset pathway are you testing that causes the problem? I'm not
fully clear on why checking for DRQ is legitimate here. Does this new
condition fire before or after the registers have been reset as part
of the reset ...?

I trust you there's a problem, but I don't know the specifics of it
just yet to understand your proposed fix. (I have a nagging fear that
it might trigger in more circumstances than we want it to, but I need
more info to audit that.)

I'm also concerned about -- depending on WHEN this conditional will
fire -- the effects of processing the end-of-transfer block on a newly
reset (or about-to-be reset) device.

>
>
>
> I have a test setup that I use to reproduce this (that was mentioned in t=
he original CVE disclosure). My patch ran for 24+ hours successfully. I can=
 test any other proposed fix.
>
>
>
> Regards
>
> Simon


