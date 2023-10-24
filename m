Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEDE7D4E34
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 12:46:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvEvL-0000ue-SB; Tue, 24 Oct 2023 06:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEvB-0000qK-SN
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qvEv5-0000Hc-D9
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 06:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698144353;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8419Vh1qVhXm+GBQvV+rvq0oKSGTKvIZwQ/tOIk4OU8=;
 b=S54qmI/0yJi/nVV+4nY43Yn+1mk/wSjjKuR0CHM09+hKvM99AnFn1zVzKWe6w7MbYEyuwu
 gy5S93srj5D5fJuFQtASkJJc01qfwYKd8JujImofTIwjQ2zn15uSHNGXyt6XfXBGAf0BO9
 8utoorvfC46qOXYv3SryWKRSWsxQpAg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-7D7FUKtGP4m2LqptHscJyw-1; Tue, 24 Oct 2023 06:45:51 -0400
X-MC-Unique: 7D7FUKtGP4m2LqptHscJyw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-408374a3d6bso27277905e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 03:45:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698144351; x=1698749151;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8419Vh1qVhXm+GBQvV+rvq0oKSGTKvIZwQ/tOIk4OU8=;
 b=V881oZkrFa05Bkms004V0BIDBnfjSSrhqgFbYjedjCZq56KNeq3FrTGmWqrYvxcuNT
 46Y3y0kdQYIQt6iHmv6C/BwrRvLjAmtd0PRrYEM/gkNvaUobPAs1VmbWQdukJKFz8Oi+
 mFWRJ+FvEcZhcT6CZ7UYJyXwR97FGARPzYVnoFTBipLiuyGYv+x338MkyqnEhmUWMWUv
 VUXVANkmAuctE7IFP4miPSa58t2Z1RGKyEbJuRPZJM+15HrXVqZgwe+/bqprmLjA7Wle
 ba5l7qmE3+MGfsnXc8Um8UHbyjbcernAnfbPdVjoE64A18cR60fWSK8UXofTownmM/an
 z+wg==
X-Gm-Message-State: AOJu0YwfkwNHYpAsQhDnOxvRaRvdVfD0Kq4xhSIngpxBHlDsAtvTsBAQ
 kiLCjUof3Mu8Tk3HDrPXyYTQhZ4AqG7GDJ/J4j3saRjNKbBXShAyrLcL1nBzHg/pe8M/1hfHqqe
 9BfWl1knphk4AZfU=
X-Received: by 2002:a05:600c:1d9b:b0:408:3f61:cb4f with SMTP id
 p27-20020a05600c1d9b00b004083f61cb4fmr8706417wms.23.1698144350810; 
 Tue, 24 Oct 2023 03:45:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGySWPHV0qe6J7UWwcN6CTlmAi4mPU66Hts32TcGpoFzTX2Sewsz+R8JRYw+4mDBnzqi4hzQ==
X-Received: by 2002:a05:600c:1d9b:b0:408:3f61:cb4f with SMTP id
 p27-20020a05600c1d9b00b004083f61cb4fmr8706406wms.23.1698144350519; 
 Tue, 24 Oct 2023 03:45:50 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 u1-20020a05600c210100b004068de50c64sm11512795wml.46.2023.10.24.03.45.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 03:45:50 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  John Snow
 <jsnow@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Samuel Thibault <samuel.thibault@ens-lyon.org>,
 qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jason Wang
 <jasowang@redhat.com>
Subject: Re: [PATCH v2 8/9] test-vmstate: add some subsection tests
In-Reply-To: <20231024084043.2926316-9-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Tue, 24 Oct 2023 12:40:42 +0400")
References: <20231024084043.2926316-1-marcandre.lureau@redhat.com>
 <20231024084043.2926316-9-marcandre.lureau@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 24 Oct 2023 12:45:49 +0200
Message-ID: <87wmvcz4bm.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

marcandre.lureau@redhat.com wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Check subsection support, and optional handling.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


