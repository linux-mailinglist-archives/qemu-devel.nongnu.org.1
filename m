Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424A7DF122
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 12:28:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyVqL-0003vm-6K; Thu, 02 Nov 2023 07:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyVqC-0003vW-Cw
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:26:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qyVqA-0003Rc-LG
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 07:26:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698924381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+CwNaj3qjZMqXBJz3u326GZ61VP0G7l3pCAg7WuH5I=;
 b=d7favg+9qfm36s4Nz7kvXNjCdcicM/as7fWJv6SmoQY9MT/i9gFA1DKe+dyCK3xWYxgnmC
 Y05BZzeECkGeNEoYx7WYdSJUQ+Ujsw+06rZKyiZwMwdzUOewq48y+P+NRZkCHR4jXIBcC3
 gOWwBS52UUVhzbcFw/Wop0UkJaw7+Aw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639--sCr__TYP3yPm9Mz_izpqg-1; Thu, 02 Nov 2023 07:26:19 -0400
X-MC-Unique: -sCr__TYP3yPm9Mz_izpqg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4090181eec2so5383115e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 04:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698924378; x=1699529178;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k+CwNaj3qjZMqXBJz3u326GZ61VP0G7l3pCAg7WuH5I=;
 b=apxfCyUZ6sPDHMFGKh8RHcFyoM6F/b15ldy+3OzkDpc2eJN+okTt6fABAa8XkNurWW
 ZzmDMPDLp7cKMtyldtDeAOtyIRO+xeALYzNiyKwRcE3PdXSIEOkbyMApm5Kq6lUO+WqZ
 qoNKQb85Eow6LQ0D8dZ8sLeSBIZJbVuXPaDy1tlbvbTbUJx/CeJJTHkS1BdAMAGpKP8b
 oAKVonfy5ywVCGZXpWSolY+2GQR9G6aPsL9+rTmTgh0m7qCYWS4/KNXhn/M6UqTkgq1r
 IXZ5NuS2XyhWbZqr6SayFNMRlUrriJPVP4hyJ9qR8oNfhHiJcL5epPYrMVsa8RTwkwz2
 h7yA==
X-Gm-Message-State: AOJu0Yy8ZLbEa+1FZTkmEJnL15TXX7sGuuZukjN4jKPRXPcNI6drwPqG
 GJNwDgo1qvl2ckpqHSfprlyFvzgc2gX+h/oLZxclCASMAZlJcU8QNjHXAounBtsOCj3KjG5ZACq
 GY4MfIRhvt5JK5kQ=
X-Received: by 2002:a05:600c:45c9:b0:406:5359:769f with SMTP id
 s9-20020a05600c45c900b004065359769fmr15225982wmo.0.1698924378633; 
 Thu, 02 Nov 2023 04:26:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwEByNXpXGEwV7ZacTdsxjnJJcTKZsiZgHlg+T0KSUWYfuogWE5xhzP7oOwPXKDi/OW2D0CA==
X-Received: by 2002:a05:600c:45c9:b0:406:5359:769f with SMTP id
 s9-20020a05600c45c900b004065359769fmr15225971wmo.0.1698924378234; 
 Thu, 02 Nov 2023 04:26:18 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a1c770a000000b00401bbfb9b2bsm573790wmi.0.2023.11.02.04.26.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 04:26:17 -0700 (PDT)
Date: Thu, 2 Nov 2023 07:26:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Andrew Melnychenko <andrew@daynix.com>
Subject: Re: [PATCH v6 11/21] virtio-net: Return an error when vhost cannot
 enable RSS
Message-ID: <20231102072540-mutt-send-email-mst@kernel.org>
References: <8880b6f9-f556-46f7-a191-eeec0fe208b0@daynix.com>
 <CACGkMEv=A0KS-LtgZmsMehdoUL=EuQzhkfNipKaV1kdUr2Y5Bw@mail.gmail.com>
 <d0db0fb1-0a58-45b7-a623-df6ee9096e2e@daynix.com>
 <20231101023805-mutt-send-email-mst@kernel.org>
 <39a02a4c-f8fa-437c-892f-caca84b8d85d@daynix.com>
 <20231101050838-mutt-send-email-mst@kernel.org>
 <e469b33b-c3f3-4d88-bdf2-508c4a35c827@daynix.com>
 <CAOEp5OcDMdKKPHSVd-GxT-GkBpvbWkMijSBgwihPsEnxmDR7eA@mail.gmail.com>
 <20231102053202-mutt-send-email-mst@kernel.org>
 <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOEp5OefD2LN2MDnEkE=DOMSX0Jw8Z6gAiKAag4dtkecmr1Jgg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
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

On Thu, Nov 02, 2023 at 12:20:39PM +0200, Yuri Benditovich wrote:
> 
> 
> On Thu, Nov 2, 2023 at 11:33 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
>     On Thu, Nov 02, 2023 at 11:09:27AM +0200, Yuri Benditovich wrote:
>     > Probably we mix two different patches in this discussion.
>     > Focusing on the patch in the e-mail header:
>     >
>     > IMO it is not acceptable to fail QEMU run for one feature that we can't
>     make
>     > active when we silently drop all other features in such a case.
> 
>     If the feature is off by default then it seems more reasonable
>     and silent masking can be seen as a bug.
>     Most virtio features are on by default this is why it's
>     reasonable to mask them.
> 
> 
> 
> If we are talking about RSS: setting it initially off is the development time
> decision. 
> When it will be completely stable there is no reason to keep it off by default,
> so this is more a question of time and of a readiness of libvirt. 

Well when we flip the default we'll need compat machinery for sure ;)

-- 
MST


