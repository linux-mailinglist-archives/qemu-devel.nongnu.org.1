Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9818115F2
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 16:17:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDQzC-00085o-D3; Wed, 13 Dec 2023 10:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rDQz9-00085I-S7
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:17:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rDQz5-0000qB-RB
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 10:17:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702480633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wrZcY0kj0f+Jn6ir9oFEXKSCe9ajbByojI6S2iSvNQ0=;
 b=WFvJdXemG7ETdNijc0hMGwZE+rGVFc7vY1g+ey0djzcmzCaF41AGvlhiDHvzf8DfkHSbAc
 /R4wuvlVS0bVSmd4egJ38eVxYPM+gmBq/XjGeVqhm6OHK17TDtnPkB6nOavcXqQR2rYgbB
 zNss3gT7y9TwRz+EykVdA/I5Dif4e30=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-weE71EFLPu2wgijf0afhdg-1; Wed, 13 Dec 2023 10:17:11 -0500
X-MC-Unique: weE71EFLPu2wgijf0afhdg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9fffa4c4f28so263433366b.3
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 07:17:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702480629; x=1703085429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wrZcY0kj0f+Jn6ir9oFEXKSCe9ajbByojI6S2iSvNQ0=;
 b=ZcnsNLKZDzNRwaZ4IBAzcwITWa21PC6lhKITt3imabIg1zu4hlKUE+etvq3eLJMpHR
 /Dj+/ScGzFnaSlUHOlPjGSJDYJug+PZBWz1DTazPacOBMdEK/Bu/ryCv2l+LzjMO6qT6
 QsY1G7z/5HlVZOytLxEWTuiBaciwRw/7R9jhgfF9PbANFdWpzWrh34W/rzOym0JGzPRj
 oLC/j4+64bMlPPDGOKNpnfVoRFsavFJdMz11SbKuORb3N64CiQiHgFqolChEEk5F+aeQ
 yZ3Psm1oFt5QsA/KKS5Pv+Pxp+EcffJfpFnoETzdEsaKwelxIEb4S3krLIW2xQu0x6UK
 1Tpg==
X-Gm-Message-State: AOJu0Yxosb2U5bdqKcIu442BTeiB3oc4H3WSIFx6kvuzD8nk1QYFUYJr
 g9N3qkXIIKZfFtcD2HNubFYE3lc/+2IrkaD0uCXUlfr6jlSksMDQV4xioYtFA1m9k7RbJxjirun
 JpFZORxfwnzZKn3o=
X-Received: by 2002:a17:907:707:b0:a10:c6ab:9cbe with SMTP id
 xb7-20020a170907070700b00a10c6ab9cbemr5652471ejb.46.1702480629542; 
 Wed, 13 Dec 2023 07:17:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiWL2JvxdrKFqyoyXgYEsDhVSS9DcjMSUvEt2IIAlLEgjtS2nDaK3Yi4hUfeqELOCWSJuVRw==
X-Received: by 2002:a17:907:707:b0:a10:c6ab:9cbe with SMTP id
 xb7-20020a170907070700b00a10c6ab9cbemr5652461ejb.46.1702480629231; 
 Wed, 13 Dec 2023 07:17:09 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
 by smtp.gmail.com with ESMTPSA id
 ig8-20020a1709072e0800b00a1d754b30a9sm7859919ejc.86.2023.12.13.07.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 07:17:07 -0800 (PST)
Date: Wed, 13 Dec 2023 10:17:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PULL 6/6] tests/acpi: disallow tests/data/acpi/virt/SSDT.memhp
 changes
Message-ID: <20231213101629-mutt-send-email-mst@kernel.org>
References: <20231213105026.1944656-1-kraxel@redhat.com>
 <20231213105026.1944656-7-kraxel@redhat.com>
 <AD96681F-FBF0-4AB9-8F2B-5B6C1FB5A52F@redhat.com>
 <20231213093242-mutt-send-email-mst@kernel.org>
 <98BBB08F-31A9-48B8-9DAF-CF32E1F8B742@redhat.com>
 <20231213100321-mutt-send-email-mst@kernel.org>
 <dr77dip25isnjsfs3llxuxpxnym5dxwovwaruqvnjw5s6ydgou@7sni32qgde44>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dr77dip25isnjsfs3llxuxpxnym5dxwovwaruqvnjw5s6ydgou@7sni32qgde44>
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

On Wed, Dec 13, 2023 at 04:14:00PM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > I agree, Gerd, going forward please include the diff of the
> > disassemled AML.
> 
> That is in patch 5/6 which updates the test data.
> 
> take care,
>   Gerd

Oh I double checked and you are right, I'm not sure where did I look that I missed it.
Pls ignore.


