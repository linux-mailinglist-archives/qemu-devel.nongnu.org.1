Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D32761C43
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 16:51:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOJMt-0006Zn-TR; Tue, 25 Jul 2023 10:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOJMm-0006YU-3W
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qOJMk-0007c8-JN
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 10:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690296621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ffoXtbm59woV+wjftdLopj0ek5JGQ8E+FVSfVqX+Gu0=;
 b=elJ0leCr1q5Vm5VbsIe+EKWcNO+aZAec4Oo++4VdkboS7+dCppWvUil2U7SlkaGfu8C48H
 ZHU3mryYEuZ3OpbgDzI+8fAOAy6q11+rIYLa3VSJFZNLb2NasI7A41Itz8uS8exJL2AyEy
 +GFvWkSgToi7p5GUl5Iy0uJP2tzRmEg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-TKH72-5iO6mw4WQAobwirA-1; Tue, 25 Jul 2023 10:50:20 -0400
X-MC-Unique: TKH72-5iO6mw4WQAobwirA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-521a38098faso3647262a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 07:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690296617; x=1690901417;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ffoXtbm59woV+wjftdLopj0ek5JGQ8E+FVSfVqX+Gu0=;
 b=jy0yOprzyfqa8SPBID6oJwjl8GwfrWPgK9qhn1JmvA4HQMoBL16MafEIB5lM+lDyb5
 XO/xGJO8pekuOu5DQM2Oe1gUND8GBz1jZCtGkaY3VjcBc4rAdZDDyimv7pRlhvglwO3r
 eUr7dIM3fFcumVQjXOMdLyFjKsByP0d/9kwWZfocKqYCTPkBW47Rl7p+hsbwWYvdp/X7
 cVW14FupcbiOwmdkUDGHtE0hQutLA5rkPtAayHsCKCOYH6TEbDaNJJhGajXcu0nuFvm8
 9IwEVOiGbu1k8SBE+KQdXK34bswTK1e6REki/q6GDWl3l1I0pfcDzUluqg02U2i45fvq
 OqGQ==
X-Gm-Message-State: ABy/qLZjLCmaxpiXq9M6hPy/FHpQQ/Yklu72HU/wwNOWLRheI07ol91q
 zbdm9GVk02laCkQ21IVQzXPaR6RPzfMFvJbKpg6D2LHYGeO2Zh8L3pR13l6HESzHOY8aVYd+z98
 dkEZFZtdUJXpmr78=
X-Received: by 2002:aa7:c048:0:b0:51e:344f:81ae with SMTP id
 k8-20020aa7c048000000b0051e344f81aemr10827516edo.14.1690296617452; 
 Tue, 25 Jul 2023 07:50:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGaZI5YEwT6GQZoz/G9g3VPLFg5EVtVqJXk4qoBIhecn5bcYqzBuOt4gBu2XRM9Ixe6kIoqdw==
X-Received: by 2002:aa7:c048:0:b0:51e:344f:81ae with SMTP id
 k8-20020aa7c048000000b0051e344f81aemr10827493edo.14.1690296617170; 
 Tue, 25 Jul 2023 07:50:17 -0700 (PDT)
Received: from redhat.com ([2.55.164.187]) by smtp.gmail.com with ESMTPSA id
 t23-20020a05640203d700b005223f398df1sm1488668edw.91.2023.07.25.07.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 07:50:16 -0700 (PDT)
Date: Tue, 25 Jul 2023 10:50:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Volker =?iso-8859-1?Q?R=FCmelin?= <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <DirtY.iCE.hu@gmail.com>,
 Alex Bennee <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 01/12] Add virtio-sound device stub
Message-ID: <20230725104714-mutt-send-email-mst@kernel.org>
References: <cover.1689857559.git.manos.pitsidianakis@linaro.org>
 <ae372de5659503e08b7c55ee2a76e9ca3038748d.1689857559.git.manos.pitsidianakis@linaro.org>
 <CAJ+F1CJdbcsdHu8WmiDDS_q7ddcJ6RPOLe2XH_EBQkqJTtMw-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJdbcsdHu8WmiDDS_q7ddcJ6RPOLe2XH_EBQkqJTtMw-Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

>     +static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
>     +                             Error **errp)
>     +{
>     +    /*
>     +     * virtio-v1.2-csd01, 5.14.3,
>     +     * Feature Bits
>     +     * None currently defined.
>     +     */
>     +    trace_virtio_snd_get_features(vdev, features);
>     +    return features | 1UL << VIRTIO_F_VERSION_1 | 1UL <<
>     VIRTIO_F_IN_ORDER;
> 
> 
> ../hw/virtio/virtio-snd.c: In function 'get_features':
> ../hw/virtio/virtio-snd.c:883:27: error: left shift count >= width of type
> [-Werror=shift-count-overflow]
>   883 |     return features | 1UL << VIRTIO_F_VERSION_1 | 1UL <<
> VIRTIO_F_IN_ORDER;
>       |                           ^~
> ../hw/virtio/virtio-snd.c:883:55: error: left shift count >= width of type
> [-Werror=shift-count-overflow]
>   883 |     return features | 1UL << VIRTIO_F_VERSION_1 | 1UL <<
> VIRTIO_F_IN_ORDER;
>       |                                                       ^~
> 

Same.
https://lore.kernel.org/all/CAJ+F1CJdbcsdHu8WmiDDS_q7ddcJ6RPOLe2XH_EBQkqJTtMw-Q@mail.gmail.com/
Pls use a different client 
and pls only quote relevant part of message.


-- 
MST


