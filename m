Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11C8119FA
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 17:46:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSMV-0007Nl-Hk; Wed, 13 Dec 2023 11:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rDSMN-0007Mg-UH
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 11:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rDSML-0005EG-3r
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 11:45:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702485919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0oD/rFh+MGgnljcUb9AiFDkGKrQEWzph40n+trgc9+U=;
 b=dCIuoMkZ/qtFNQtLT26jbr0qIQH0xA0JRlXO5yGNof3PT5uY7jk5BIQBmIJ0Z+C6r9WzJg
 OpeOIu4amt9qlNOZWu6GcbaY10RjQEssTFk/ANYf7rc1a0uVVqOX6S95jXPqc/55Ae1Zzh
 kLW5+u+F9ZR34A9k16XbkqzETkP6dW0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-Yfd1n89bOXGsDR5wIKP2rg-1; Wed, 13 Dec 2023 11:45:17 -0500
X-MC-Unique: Yfd1n89bOXGsDR5wIKP2rg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a1c915eae11so857605966b.1
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 08:45:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702485915; x=1703090715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0oD/rFh+MGgnljcUb9AiFDkGKrQEWzph40n+trgc9+U=;
 b=wbrKr8bs0nwRCWenQBSdB2X5i9/MZHNAHiiRz8VoCWDIFUzQMlBhghGK47ZuzGW4RP
 A2cPL63rmg7iJhfWuc9ya2a87mdZ/jvGRmuEB4RKfk5cWIRaWuPgcSLzb9VckYdeBC8i
 1KpEh8yAFIQ+jIgW4a/95Kckcr5rsUz7k9qwTVajbXhIjpCNuZTiHnpJ1j/DQyqKhcOK
 u+PhSfOxoMSUZDYcYBty6M1uGTLH4AiMegJO7Zvd8EsQFLzexuI3YNLnHPEZtpWL3K6V
 R3dJgu0fryZrbVJcIPJ672YnEaEL+AsOuCHX691fINdArhciKFGGM4dN+gfw7JWNVhOz
 +vqA==
X-Gm-Message-State: AOJu0YwcaSeNoMMV8eE30GFOhTqSZtL693OQ6ZcQwnA587PxmeytGZP4
 +2xrQUih5hWZibu1BciVGphbH4oLfHUULnOda1taYWinkDCsI9wijRa9GOmMi+Sl2k9ZG3FXgfd
 z0mLq+OvG8d9r3wAK8q3u8VM=
X-Received: by 2002:a17:906:106:b0:a1e:f7d5:695a with SMTP id
 6-20020a170906010600b00a1ef7d5695amr8817766eje.2.1702485914895; 
 Wed, 13 Dec 2023 08:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoL/Vk+KOrgUtEnDj4YxIDmz+/02Rk1NPJWdOwrFTRyRIcNNn1Y813OWt93L6SzIa8s0GceA==
X-Received: by 2002:a17:906:106:b0:a1e:f7d5:695a with SMTP id
 6-20020a170906010600b00a1ef7d5695amr8817758eje.2.1702485914630; 
 Wed, 13 Dec 2023 08:45:14 -0800 (PST)
Received: from redhat.com ([2a02:14f:16d:d414:dc39:9ae8:919b:572d])
 by smtp.gmail.com with ESMTPSA id
 rd7-20020a170907a28700b00a1f6c2c391dsm7637698ejc.121.2023.12.13.08.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 08:45:14 -0800 (PST)
Date: Wed, 13 Dec 2023 11:45:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Vamsi Krishna Attunuru <vattunuru@marvell.com>,
 Jerin Jacob Kollanukkaran <jerinj@marvell.com>
Subject: Re: Regarding VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA
 feature bits
Message-ID: <20231213114214-mutt-send-email-mst@kernel.org>
References: <BYAPR18MB2791DF7E6C0F61E2D8698E8FA08DA@BYAPR18MB2791.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR18MB2791DF7E6C0F61E2D8698E8FA08DA@BYAPR18MB2791.namprd18.prod.outlook.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 13, 2023 at 04:27:40PM +0000, Srujana Challa wrote:
> Hi Michael,
> 
> While verifying virtio frontend drivers of guest OS on qemu with vhost-vdpa backend,
> we came across feature bits VIRTIO_F_IN_ORDER and VIRTIO_F_NOTIFICATION_DATA,
> which are introduced in virtio 1.1 spec, are not yet enabled in qemu. These feature flags
> are very much useful for achieving better virtio-net performance and most of the latest
> hardware VDPA devices supports these feature flags as per of virtio spec.

Could you share more about which device do you mean? Does Marvell ship
or intends to ship one?

> Could you let us know if there are any plans, to add support for these features in upcoming
> qemu releases.
> I guess there was some discussion on VIRTIO_F_IN_ORDER feature bit long ago,
> https://patchew.org/QEMU/1533833677-27512-1-git-send-email-i.maximets@samsung.com/
> Seems like that discussion has not reached any conclusion or further work.
> 
> Thanks,
> Srujana.

Yes that patch got comments and these were not addressed.
Feel free to address them so this can proceed.

-- 
MST


