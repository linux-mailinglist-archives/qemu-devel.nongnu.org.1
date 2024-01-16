Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5934A82ED8D
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 12:18:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPhRI-0005n5-Uk; Tue, 16 Jan 2024 06:17:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rPhR4-0005kO-E7
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 06:16:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1rPhR2-0003oU-W3
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 06:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705403807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eQ4Aw0F8n+7nGDJJCLttHsk0AEm/WReUjQNjza28HGI=;
 b=H6Ol+EeB+loVsl9yzO22CCM6FRu8dCjCwwXAHz752nsVHVHL1zLLqmjjYkGvo7T7Dd/vBW
 kOyaYkbYqS9bPTBpC4DK1aZKHVzJXpEzFVj91ezgzgh2ArUzqROieENjcqcF7C0VJP8d2w
 5gJpEEudJgYpgYmUcqpORu5OpHaE+Ws=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-L-eswz1lMQKE2U1OrbC6UQ-1; Tue, 16 Jan 2024 06:16:46 -0500
X-MC-Unique: L-eswz1lMQKE2U1OrbC6UQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6805f615543so207430246d6.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 03:16:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705403805; x=1706008605;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eQ4Aw0F8n+7nGDJJCLttHsk0AEm/WReUjQNjza28HGI=;
 b=H5JFSmB5/iIYdpTow36D+54pFb+SR9JtzFCzgJ+vj1+c3VhjFp8wU4zK/yq+9bzunF
 +aNF/vqm/xioQmf29mMq5J3hDSU8ys9NETOZwzU/kn8MP94kZJrxS6sR929zgKbZ9fzI
 lSsNM0WoJE8Sb8kP3CYAhphEOWwCGXevZHLR1hmER4FCcH6sbn1L514ioQVWMs/qPblb
 NrZcA2iTxjNev0mAmSlsD+HhUnKaKvSTy4ZgHP1UZJJ52DP3gA3UaMp13tZb3Lvx5lNL
 IuKb4QoAEz5qNYyHWGyZLO6T5QjE9XwEaij9Cm4FbdO02ojgdGICJ7GXA9SD4BShGpKI
 4qFQ==
X-Gm-Message-State: AOJu0YyO2lvdjeZ4skgfZBZzb5bEhS7qGldE9hUOeG2lH6bekmn4qLIZ
 Lr2a2azjDzjMNy5bcLgHMg2kmNFw+rR6xPSKt1VVqVU94yYqgmE2NCL12TFw4eMC+kkZips3rkR
 RHPZLDtI1BziD4qgtgGWqqyo=
X-Received: by 2002:a05:6214:21e9:b0:681:6862:3459 with SMTP id
 p9-20020a05621421e900b0068168623459mr2099934qvj.18.1705403805781; 
 Tue, 16 Jan 2024 03:16:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8OXKzyBZTWkNXWAYtWrDryghGQPoTC4KFz+tDWTxqKY8HAS6G+RJui9fPchlbPdgP9INXQQ==
X-Received: by 2002:a05:6214:21e9:b0:681:6862:3459 with SMTP id
 p9-20020a05621421e900b0068168623459mr2099922qvj.18.1705403805550; 
 Tue, 16 Jan 2024 03:16:45 -0800 (PST)
Received: from rh (p200300c93f0273004f0fe90936098834.dip0.t-ipconnect.de.
 [2003:c9:3f02:7300:4f0f:e909:3609:8834])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a0ce18c000000b00680c50735c6sm4089053qvl.88.2024.01.16.03.16.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 03:16:45 -0800 (PST)
Date: Tue, 16 Jan 2024 12:16:42 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, peterx@redhat.com, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/2] virtio-gpu: fix scanout migration post-load
In-Reply-To: <20240115154830.498304-3-marcandre.lureau@redhat.com>
Message-ID: <a67b8127-6445-a29b-ffc4-6c5409e93bbd@redhat.com>
References: <20240115154830.498304-1-marcandre.lureau@redhat.com>
 <20240115154830.498304-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
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

On Mon, 15 Jan 2024, marcandre.lureau@redhat.com wrote:
> +            scanout->ds = qemu_create_displaysurface_pixman(res->image);
> +            if (!scanout->ds) {
> +                return -EINVAL;
> +            }

"qemu_create_displaysurface_pixman() never returns NULL." ;-)


