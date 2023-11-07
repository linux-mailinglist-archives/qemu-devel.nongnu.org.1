Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 165DA7E36E4
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 09:47:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0HjN-0000wM-NE; Tue, 07 Nov 2023 03:46:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0HjM-0000vi-6C
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:46:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r0HjK-0002g6-Bv
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 03:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699346797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Yd3+rWWaZo+CYrr7kIDR+cpNL7vsCTyKF0xG+exMj4=;
 b=VtEdRifbaN3HgxoWEAKLtPokCEmE4PViCZF66/rs334+0HCRh7cJrvOpd5utrFcu7xnRG5
 6e4RgFaNccmMJhryFkFrGKraHMNnVtr7b+AH5JRKmVO8G40xZBMzZCdaBF9js75ciKcbfu
 shGl/RV5u3JiBy0dXp732yieNmTOi20=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-b0a7FB3zOz-eE_Qw_K8v7A-1; Tue, 07 Nov 2023 03:46:36 -0500
X-MC-Unique: b0a7FB3zOz-eE_Qw_K8v7A-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-507cb169766so5385771e87.0
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 00:46:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699346794; x=1699951594;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Yd3+rWWaZo+CYrr7kIDR+cpNL7vsCTyKF0xG+exMj4=;
 b=vS5uyP3fomtZ446ev66XSYowhdUQ9G1blGk3WLNOR5hKLb1mjPQVLaIy7IRVYaFCXW
 gteW1oEGmw3oEZN9HKu0WS8yaCxylGdTLsgROAyaiImzujMIlXXG6qRlDIFIu9Rb1zxU
 rEs27/xDFp9OqjtUL/8o65sAWrHgtSogRKYjknEVGJ94whqG2lseHaDc9GY+JEUjVrZQ
 0anfyc/cx3Z/FXNABMv5tEAJ8Vt1CDiuZdjVQMi9rdF6ceiiPa3HcktZ/lrQcyncMRnC
 E1ePZ1+y3JkHvvrJ/DTfQrqMH8yDUJoDLH7HdMNpf1NDNJu4AyR6nsLfFo0i4moPkbrG
 PPIQ==
X-Gm-Message-State: AOJu0YzEZe76jiHLdTynYH8wp3yslnWtcWFoOJ4RIcqqY2PG0M2//wNZ
 Md7KGG1bo0D+4ep93D4YkAkx9miEwRTkzWHmze5aR7ZMsFWA0BebY2QkjVKQ1s50dNi5YuqdxrX
 XuoHlqn6GUD3ehVE=
X-Received: by 2002:ac2:5925:0:b0:507:9fc1:ca7a with SMTP id
 v5-20020ac25925000000b005079fc1ca7amr23058183lfi.9.1699346794477; 
 Tue, 07 Nov 2023 00:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdp85apcB1Vg0uC/F6cnLFuOJI/7RGB38INlFUtbOcQ8XQs3QggXRbvkDa3WcXBfarUeMD8A==
X-Received: by 2002:ac2:5925:0:b0:507:9fc1:ca7a with SMTP id
 v5-20020ac25925000000b005079fc1ca7amr23058159lfi.9.1699346794040; 
 Tue, 07 Nov 2023 00:46:34 -0800 (PST)
Received: from redhat.com ([2.55.35.37]) by smtp.gmail.com with ESMTPSA id
 g4-20020a05600c310400b004068e09a70bsm14916539wmo.31.2023.11.07.00.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 00:46:33 -0800 (PST)
Date: Tue, 7 Nov 2023 03:46:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>, virtio-fs@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Kevin Wolf <kwolf@redhat.com>, Erik Schilling <erik.schilling@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v6 0/6] virtio: cleanup vhost-user-generic and reduce c&p
Message-ID: <20231107034521-mutt-send-email-mst@kernel.org>
References: <20231106191515.2801863-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231106191515.2801863-1-alex.bennee@linaro.org>
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

On Mon, Nov 06, 2023 at 07:15:09PM +0000, Alex Bennée wrote:
> A lot of our vhost-user stubs are large chunks of boilerplate that do
> (mostly) the same thing. This series continues the cleanups by
> splitting the vhost-user-base and vhost-user-generic implementations.
> After adding a new vq_size property the rng, gpio and i2c vhost-user
> devices become simple specialisations of the common base defining the
> ID, number of queues and potentially the config handling.
> 
> I've also added Manos' vhost-user-sound while I was at it.
> 


gpio tests seem to be failing under clang:

https://gitlab.com/mstredhat/qemu/-/jobs/5475281549




-- 
MST


