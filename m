Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F2BB7AD584
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 12:11:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkiXB-0001LA-M4; Mon, 25 Sep 2023 06:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1qkiX8-0001Kv-CK
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 06:09:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1qkiX5-0006Ig-Ge
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 06:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695636577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uFK/RPhsTa4+73IgpH3Vh6lz39jbiLgEPDMsrp7cJw4=;
 b=NDiZyMJRLFfVp6vLfSPPS7oPjifig9NDsS2lWBR5IXXlqcsvIOx2FAsik0ScBfxPE30KCI
 iWtUGQgJRpG82U1+IAEendUY6jhWhDMJYXetbjCK/JPMwDECv1K5D8qB+KrEmc2wJx0OFl
 ozawlZR/6plY4iF1fnl8ZGd/j7+FFxo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-hIRaG4MrNYabNxxjjAc4-Q-1; Mon, 25 Sep 2023 06:09:36 -0400
X-MC-Unique: hIRaG4MrNYabNxxjjAc4-Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4054743df06so38133175e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 03:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695636575; x=1696241375;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFK/RPhsTa4+73IgpH3Vh6lz39jbiLgEPDMsrp7cJw4=;
 b=H9TYg5OxEEDmXf4uq2nm+LCDTP2ddwVz3rJo+vSdVYlIUg673FzQQAFaWUpA5qLpa0
 3Ve1nq5YC+wzvZIsnTyCT3WbYZiiO6PvqtIfdAaqq5bNXfez9USAVE1hlqb0tn4T1zpl
 H7jpltojUQlgGf+eoPCjdW0oTppveS7JbWrkV1R7bUc7A2aQ0kiJQXwTYybxP86YKddP
 lrDS6hr3YBywIVeXQ9FAufKyeRRad1+bE6OwQutqM7/GJ/+BKh5uwo9qtqyOeHQQkGt3
 Uq0D/l1kukTXlBhq/lfIU5Rjfe1CE/QWLA6Pag+hPHbKeudtV7ARxgjVeNeuhx6pbB5t
 O/ig==
X-Gm-Message-State: AOJu0Yy5zqn0f5WOzLXo6A0xMs6kvY9s219RWzSRgXoTwJuaVn9WabKl
 adXeqVAm8BhFEcSvwKEUb2pcoJEi0f8RpSjZI+Mg5AXvVgDFOZiZnxROLFZr/3JwIrdppDXRIpg
 D3hXsbjn943xq0fo=
X-Received: by 2002:a7b:cb97:0:b0:405:4daa:6e3d with SMTP id
 m23-20020a7bcb97000000b004054daa6e3dmr5085748wmi.39.1695636574940; 
 Mon, 25 Sep 2023 03:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJKl3UdBHOZkXsyhdwNbYLPiGZYTR4q0jVwlJBN7xdUeFFv4xSGPLf7LnQArf2TJf/QCgq6Q==
X-Received: by 2002:a7b:cb97:0:b0:405:4daa:6e3d with SMTP id
 m23-20020a7bcb97000000b004054daa6e3dmr5085735wmi.39.1695636574649; 
 Mon, 25 Sep 2023 03:09:34 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a05600c21ce00b003fefcbe7fa8sm11810476wmj.28.2023.09.25.03.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 03:09:34 -0700 (PDT)
Date: Mon, 25 Sep 2023 12:09:32 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Igor Skalkin <Igor.Skalkin@opensynergy.com>,
 Anton Yakovlev <Anton.Yakovlev@opensynergy.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Volker =?iso-8859-1?Q?R=FC?= melin <vr_qemu@t-online.de>,
 =?utf-8?B?S8WRIHbDoSBnw7MgLCBab2x0w6E=?= n <DirtY.iCE.hu@gmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9?= e <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v9 00/12] Add VIRTIO sound card
Message-ID: <ZRFcXN+sv6gO1GQx@fedora>
References: <cover.1694588927.git.manos.pitsidianakis@linaro.org>
 <2gm4wkfnjopd7l5zvzepzknl4hfomkxvtgvw72daazne2n34wy@fgqmh3mi3r5l>
 <0yzxl.gd0zk711fja@linaro.org>
 <udfmt4up4fjf5optfrl3242zakngwfwrti7dok6h4ejenvesaq@korfb3dd4nts>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <udfmt4up4fjf5optfrl3242zakngwfwrti7dok6h4ejenvesaq@korfb3dd4nts>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvaralar@redhat.com;
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

On Thu, Sep 14, 2023 at 12:24:13PM +0200, Stefano Garzarella wrote:
> On Thu, Sep 14, 2023 at 01:02:05PM +0300, Manos Pitsidianakis wrote:
> > On Thu, 14 Sep 2023 12:54, Stefano Garzarella <sgarzare@redhat.com> wrote:
> > > We are seeing something strange with the virtio-sound Linux driver.
> > > It seems that the driver modifies the buffers after exposing them to
> > > the device via the avail ring.
> > 
> > I need more information about this bug. What is the unexpected behavior
> > that made you find that the buffer was modified in the first place?
> 
> CCing Matias for more details, but initially can you just run the test
> Matias suggested to check if you experience the same behaviour or not?
> 
Hello, 
we are discussing this issue in the virtio-comment mailing list:
https://lists.oasis-open.org/archives/virtio-comment/202309/msg00175.html

Thanks, Matias.


