Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D42A27AAF98
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:36:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdWT-0001zc-JE; Fri, 22 Sep 2023 06:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qjdWR-0001zR-He
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qjdWQ-0000uc-4K
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695378989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w8eBvV7/pHzL+IyVLI5tsK9sDMKgawvapckiowcmJbo=;
 b=IiftEdefeII2+dzpRhWpGHKGxvNUYorwoUW/J4l9j3JbeLDrQPsf3dfTbBQhfFQYndjeXt
 GD7XPiEOwGhriKn2DkzRgAlB7AzxQsJFbucP9fJDJqwfo9QS7/PI/BOxqBobwiok4+ritD
 O1SFafmczqG692jY4PwcTfKpHwMZEXA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-HXFFqVJAOYahCjZfQHH2eA-1; Fri, 22 Sep 2023 06:36:28 -0400
X-MC-Unique: HXFFqVJAOYahCjZfQHH2eA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9aa20a75780so151387466b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 03:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695378987; x=1695983787;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w8eBvV7/pHzL+IyVLI5tsK9sDMKgawvapckiowcmJbo=;
 b=gY0MbJTwxoXEVUp3S3KE8N0RWlUUYEvHGf0t0tDONI8OYZv/TD+cDCadP5u5KkqBEi
 zHWbrk9Dx/3qBckPYW6QwjD16VhTfnw2UHCnkmzEwuuRoI9asBW3HH2KF34iTbF6a13/
 l4b7/RnL59ESx40UluURi1cRRCgx5rj+fpNerRNE8dxJ8LWbKRVqlHhmPGzglMVHKc1R
 YEMJsBuygfZ1fUNWo42LYL3Yg1/l2zAh1q86Aqyux41f/ufgoMjSkKf+ki5MjSCgcJOI
 nMNIFi7CQSeThHZsGRhkCqoAGYbpKqT00T2v5XmEIPtDuf7LubY8NXIM6GToMmNg4S1p
 83vg==
X-Gm-Message-State: AOJu0YwM7lkb+T6RSzF/INEV4Q/ak+u0hEL48i250AFoEGWeSIy2VYla
 J7QC/o2UzjFsmEZeOwSr+JPXCzdmc3vY2HzGDCPgXuGgVTuvhdFnrdrGy8QA64DH/rGPw3UJQ3a
 l4hgEf50bsgj3bKY=
X-Received: by 2002:a17:906:8a6e:b0:9ae:5643:6498 with SMTP id
 hy14-20020a1709068a6e00b009ae56436498mr4684505ejc.19.1695378987025; 
 Fri, 22 Sep 2023 03:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE93hng4Cr1hKJiqsjdm+5EiIAKTNK5Zab+Y6GVoLn1u49P5Ttww3FbKZCuril4sHGV/5KOdQ==
X-Received: by 2002:a17:906:8a6e:b0:9ae:5643:6498 with SMTP id
 hy14-20020a1709068a6e00b009ae56436498mr4684473ejc.19.1695378986714; 
 Fri, 22 Sep 2023 03:36:26 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 o16-20020a17090608d000b0098d2d219649sm2574856eje.174.2023.09.22.03.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 03:36:25 -0700 (PDT)
Date: Fri, 22 Sep 2023 06:36:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Alberto Garcia <berto@igalia.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Andrew Jeffery <andrew@aj.id.au>, Brian Cain <bcain@quicinc.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <eduardo@habkost.net>,
 Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>,
 Fam Zheng <fam@euphon.net>, Fan Ni <fan.ni@samsung.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Laurent Vivier <laurent@vivier.eu>, Laurent Vivier <lvivier@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: Help wanted for enabling -Wshadow=local
Message-ID: <20230922063552-mutt-send-email-mst@kernel.org>
References: <87r0mqlf9x.fsf@pond.sub.org>
 <5255ABB8-8D1D-4AF4-9015-84573056973C@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5255ABB8-8D1D-4AF4-9015-84573056973C@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 22, 2023 at 04:03:27PM +0530, Ani Sinha wrote:
> 
> 
> > On 22-Sep-2023, at 3:07 PM, Markus Armbruster <armbru@redhat.com> wrote:
> > 
> > Devices
> > -------
> > ACPI/SMBIOS
> > M: Michael S. Tsirkin <mst@redhat.com>
> > M: Igor Mammedov <imammedo@redhat.com>
> > R: Ani Sinha <anisinha@redhat.com>
> >    hw/acpi/cpu_hotplug.c
> >    hw/i386/acpi-build.c(*3*)
> >    hw/smbios/smbios.c
> 
> I will look into this after enabling
> 
> diff --git a/meson.build b/meson.build
> index 98e68ef0b1..9fc4c7ac9d 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -466,6 +466,9 @@ warn_flags = [
>    '-Wno-tautological-type-limit-compare',
>    '-Wno-psabi',
>    '-Wno-gnu-variable-sized-type-not-at-end',
> +  '-Wshadow=local',
> +  '-Wno-error=shadow=local',
> +  '-Wno-error=shadow=compatible-local',
>  ]


Am I right that one can equivalently do
./configure --disable-werror --extra-cflags='-Wshadow=local -Wno-error=shadow=local -Wno-error=shadow=compatible-local'
?


