Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49549A6D8F0
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Mar 2025 12:14:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twfjn-0003gJ-Ok; Mon, 24 Mar 2025 07:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1twfje-0003fp-JI
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 07:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1twfjc-0005YI-F0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 07:12:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742814763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itDCzw6wodbNZOQyFYut+lOxcV1qin1ejSQjigw8uvQ=;
 b=QdjaCThoeuqfLlKb+m0g5tyjgXHwcwqYauHDvzx67gmMb9wiVIJCaqybdFPvKLTlPs1ILI
 JC0vKlTUWTvN/OYX7Fja89e+xBB3e5fyQ00L5LML1cyuagaHQeWAIyBmlKz6ESSCCvXGtE
 6g47wjBGxrfSoIZrVCa4x5PruXMaREs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-wJ5rmYPzNeqjBcHmJTKC5g-1; Mon, 24 Mar 2025 07:12:41 -0400
X-MC-Unique: wJ5rmYPzNeqjBcHmJTKC5g-1
X-Mimecast-MFC-AGG-ID: wJ5rmYPzNeqjBcHmJTKC5g_1742814760
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abb9b2831b7so483194666b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 04:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742814760; x=1743419560;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itDCzw6wodbNZOQyFYut+lOxcV1qin1ejSQjigw8uvQ=;
 b=OzD1yUudFcUIAGkb0ds4BB07lSx0z86nHXDwaJjcoK/y7e1arbBR3bmOlb7EsNS5mA
 7XCrTsy9pc+XWCWXos+HHJer+cETbkQUHerBO5qKxN3fgxo35nU+rxsQnjg1YwyD//lO
 blKY/s4F+ZLhmZShY6p5CgS95NKanNWtG0BVN1X2u9Z266AwDU6VYMmr1V1mHpadD1JS
 aHc8hUJLobw3eCpooUfQnAyyY8OljJsCfMMk+nwMluB5l5/0HBBRrE1Pr0fLgIQE8VHF
 p3LODGycuUb733vQz98mOL+lREmQRf9sMRPktOFNwnsytRnMtW4kELnXg4ytVqVhJZuT
 gNNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgyelcykMs1lrDxal7Owq1BNyq9+Qlhi8UZbJ++LlhHOkg/D5PMMSqnEwb3LohTJAhXN5unGVtqVtc@nongnu.org
X-Gm-Message-State: AOJu0YyzN7mE520apvCeSHzafUHrkLbZ15JuUCQDyfDgr+o3h3T90Trv
 BxbbMJ+dJnHG0v1nR9Y8jWdKUyY3Isn0WseX+/hSHH4XQZuzt7WoFNxqW8QVQJhru3pJUMLVtOB
 Jr3Kk3GrfcXMS225MNvJ06KXOw2Xm9QsKZrUfDOox3OtzjQhPWkwUh9ZIPhU2lp1p2EB5Za2G+l
 BRrL2F/yW6vhkxigE8ObHjhfQYtDE=
X-Gm-Gg: ASbGncvtFL9zpwe3TsNfmi717w0bC6BmGKwTxOiD4X9XJg0nucV/yOtxna316IM35Ai
 bi1idS22l/V6BOKP+Cn1qtZ7SgXg13yQ/8m69dnVRZIYocWorw8CmH2Pr+D0gqOAtUgqrudOP
X-Received: by 2002:a17:907:d84d:b0:ac3:4228:6e00 with SMTP id
 a640c23a62f3a-ac3f00b2ef4mr1349810166b.6.1742814760336; 
 Mon, 24 Mar 2025 04:12:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBnsl5fXwUo0dxJvRYbaNXZPs+YwEwYOZjiy8mepvm231WuyFSef5/9CgeCWj5G5b02A40j9FAoacxxTlsVTk=
X-Received: by 2002:a17:907:d84d:b0:ac3:4228:6e00 with SMTP id
 a640c23a62f3a-ac3f00b2ef4mr1349804466b.6.1742814759854; Mon, 24 Mar 2025
 04:12:39 -0700 (PDT)
MIME-Version: 1.0
References: <Z9LeILiEU5GfEHrl@8bytes.org>
 <CAK3XEhNS10gKLh6SKeSc9cKi+_qwu3+Yu5rAkni5h7tYS59D5g@mail.gmail.com>
 <aet7vo4qwexxrw5khiwvhelvhwya3w7wuk72w77jlq7idn3me5@2ojjjdw43u7q>
 <85a9745d-e3b3-4e0e-90ad-066e6dcc25c1@amazon.com>
 <ahtt7arm3pi7rlv6x4qepktrczgnsgaukftyee75ofn5duviho@v4wp6v7wlxbg>
 <4593a2fe-098b-488b-9d55-1adc1e970f59@amazon.com>
 <vajhincsurwwx5yfmfhamgmvo5i22hxsaaef22aaknkn24m7c6@yxuntxof4iie>
 <Z9vSeF67fNazkxBh@8bytes.org>
 <4p7orqixni5m3444l53isxe5awdwasrb5e5bu6wu4phhycqpir@z22wgnaxowsg>
 <CAK3XEhNeB29eaPxZ_1Cc7WfEzOGZZPcvTc5uC1XAdtG0uNfDRw@mail.gmail.com>
 <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
In-Reply-To: <h2s75tkddnrmodbbr7hxugrivpbhq7cfpbmhmgqmnn5mlafedk@jhv5cobgtjkc>
From: Ani Sinha <anisinha@redhat.com>
Date: Mon, 24 Mar 2025 16:42:28 +0530
X-Gm-Features: AQ5f1JrohHGs7K3BCMiL7UloIn-_8-7G1nBLxiwd50wgw94QWy7n0QIDt_bPRfY
Message-ID: <CAK3XEhPYmBsn2-=PMR7qVQHiu0ydoh3EfJOEuunLccriSkKipg@mail.gmail.com>
Subject: Re: [PATCH v6] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Gerd Hoffman <kraxel@redhat.com>
Cc: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>, 
 Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Mar 24, 2025 at 1:13=E2=80=AFPM Gerd Hoffman <kraxel@redhat.com> wr=
ote:
>
>   Hi,
>
> > > Going ship the distro kernel as igvm image would work too.  Will
> > > simplify the measurement pre-calculation.  Also there is no need to p=
ass
> > > around any parameters, everything (how the firmware finds the UKI etc=
)
> > > can be arranged at igvm build time then.  Disadvantage: This introduc=
es
> > > a completely new boot workflow.  Will probably need a new set of clou=
d
> > > images exclusively for the BYOF case.
> >
> > What does all this mean for the hypervisor interface ?
>
> That means we'll go scratch the region list idea and depend on igvm
> instead.
>
> Which means we are back to the single firmware image.

So in this model, how are we passing the hashes of kernel, initrd and cmdli=
ne?
Are they going to be part of the firmware image as was previously thought?

  I think it makes
> sense to continue supporting classic rom images (which can also be
> loaded via -bios).  Any use case which needs more fine-grained control
> must use igvm.  We can use format bits in both capabilities and control
> fields to indicate what the hypervisor supports and what has been
> uploaded to the firmware image region.  See interface header file draft
> below.
>
> 'opaque' exists as before, even though I think it makes sense to also
> specify the size for the opaque blob.  This gives the guest a bit more
> flexibility in how this is used, for example it could pass the complete
> UKI as opaque blob.
>
> take care,
>   Gerd
>
> ------------------------------ cut here -----------------------------
> struct vmfwupdate {
>     // VMM capabilities, see VMFWUPDATE_CAP_*, read-only.
>     uint64_t capabilities;
>     // control bits, see VMFWUPDATE_CTL_*
>     uint64_t control;
>
>     // firmware rom/flash storage size, read-only.
>     uint64_t fw_rom_size;
>
>     // address and size of the firmware update image.  Will be cleared on
>     // firmware update and reset.
>     uint64_t fw_image_addr;
>     uint16_t fw_image_size;
>
>     // address + size of opaque blob.  The guest can use this to pass on
>     // information, for example which memory region the linux kernel has =
been
>     // loaded to.  writable, will be kept intact on firmware update.
>     uint64_t opaque_addr;
>     uint64_t opaque_size;
> };
>
> // --- format bits, used by both 'capabilities' and 'control' ---
> // igvm
> #define VMFWUPDATE_FORMAT_IGVM           (1 << 32)
> // rom/flash on platform-specific location
> //  - x86: below 4G + 1G
> //  - arm: 0
> #define VMFWUPDATE_FORMAT_PLATFORM_ROM   (1 << 33)
>
> // --- 'capabilities' field bits ---
> // vmm supports resizing of x86 firmware memory
> #define VMFWUPDATE_CAP_X86_RESIZE         (1 << 0)
>
> // --- 'control' field bits ---
> // disable vmfwupdate interface
> #define VMFWUPDATE_CTL_DISABLE            (1 << 0)
>


