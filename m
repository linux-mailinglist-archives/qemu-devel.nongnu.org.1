Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD397D0A9B
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 10:35:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtkwr-0007pi-88; Fri, 20 Oct 2023 04:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtkwm-0007ov-Mp
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtkwj-0002Ox-7I
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 04:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697790808;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6fpu/fAuK3pKdJMb1McE3nqogwVQveHzDFPZDMMtdpQ=;
 b=L1CdO6Mzi07NwLiNjypqccOA9hMuzGYBJenpe112TXYJD8GOD8QtNr437nordTUbnGjwSk
 HMWn4lZ8i+uT8GonVhPliAfFdsCcNUkqwkQFhi2nUiTFzPRxGoTlcW5RDVEH1IePGPM/Pk
 ++xfocs6WzElSHF+rJ4qyxCp54F6izA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-PK0-DDsFM1KkszGBCoOqoA-1; Fri, 20 Oct 2023 04:33:16 -0400
X-MC-Unique: PK0-DDsFM1KkszGBCoOqoA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40554735995so3401695e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 01:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697790796; x=1698395596;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6fpu/fAuK3pKdJMb1McE3nqogwVQveHzDFPZDMMtdpQ=;
 b=xAkFvAh+NlI5EuxHXn7iw5i7aXAo6mNlnrFW8tUYzfDsqSY+lI4LWkr4rgkM8A9bQ9
 K2psuJyNXBd4Wp5fvdqDoXjLcIuyX0roYIyeu6eY1X/FapcXLOnuatsZ9kzOZPVoXmNR
 YP2rVoExMMA/XbMIQyS6u+lTjkWvd5tX5Od2bwKl+txzIs1NhJwCurYZtyRMZIvd+cKv
 FtUbHmh1+i8jKILtxRUmTfifLZfXRp2jaUw31RgOr8Ca9tUWMxV7cw2gHhaNOp8ac4Oh
 1HBRkFDgAS98iSFcIbGqpfgAXYRU3B/Z3cVO543oWxKLW+An9d7txG9OcLNajDB1NahE
 /wsQ==
X-Gm-Message-State: AOJu0YybCGTUvlvjMf1AcZopPm79iR558HYEhpomKXiUNe65vbhLE2uX
 /Gx6QRfhSrjbzCS3SGeIMWKwCXSBPQ/M95P4IIYu4mVHH6fqvx5qWpr0U1j2y6XAYVs/CdxSkUT
 YJBHbLXGGJM4Mlko=
X-Received: by 2002:a05:600c:3b17:b0:405:39c1:a98b with SMTP id
 m23-20020a05600c3b1700b0040539c1a98bmr950166wms.20.1697790795808; 
 Fri, 20 Oct 2023 01:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDevudImY2WUIGWb8uxrw3VG8MszuVlC1Y0EviraBzwQgOP5Fo3Cuc0AiT6r+JvhizTLIvHA==
X-Received: by 2002:a05:600c:3b17:b0:405:39c1:a98b with SMTP id
 m23-20020a05600c3b1700b0040539c1a98bmr950137wms.20.1697790795423; 
 Fri, 20 Oct 2023 01:33:15 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c4e8e00b004064288597bsm1595702wmq.30.2023.10.20.01.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 01:33:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Nicholas Piggin" <npiggin@gmail.com>
Cc: "Greg Kurz" <groug@kaod.org>,  <qemu-devel@nongnu.org>,  "Stefan Berger"
 <stefanb@linux.vnet.ibm.com>,  "Marcel Apfelbaum"
 <marcel.apfelbaum@gmail.com>,  <qemu-ppc@nongnu.org>,
 <qemu-s390x@nongnu.org>,  "Gerd Hoffmann" <kraxel@redhat.com>,  "Corey
 Minyard" <cminyard@mvista.com>,  "Samuel Thibault"
 <samuel.thibault@ens-lyon.org>,  "Richard Henderson"
 <richard.henderson@linaro.org>,  "David Hildenbrand" <david@redhat.com>,
 "Ilya Leoshkevich" <iii@linux.ibm.com>,  "Fabiano Rosas"
 <farosas@suse.de>,  "Eric Farman" <farman@linux.ibm.com>,  "Peter Xu"
 <peterx@redhat.com>,  "Harsh Prateek Bora" <harshpb@linux.ibm.com>,  "John
 Snow" <jsnow@redhat.com>,  <qemu-block@nongnu.org>,  "Mark Cave-Ayland"
 <mark.cave-ayland@ilande.co.uk>,  "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  "Stefan Weil" <sw@weilnetz.de>,
 <qemu-arm@nongnu.org>,  "Jason Wang" <jasowang@redhat.com>,  "Corey
 Minyard" <minyard@acm.org>,  "Leonardo Bras" <leobras@redhat.com>,
 "Thomas Huth" <thuth@redhat.com>,  "Peter Maydell"
 <peter.maydell@linaro.org>,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,  "David Gibson"
 <david@gibson.dropbear.id.au>,  "Halil Pasic" <pasic@linux.ibm.com>,
 "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 07/13] RFC migration: icp/server is a mess
In-Reply-To: <CWD3OHT178VU.3NF8B5Y5BOK1S@wheely> (Nicholas Piggin's message of
 "Fri, 20 Oct 2023 17:49:38 +1000")
References: <20231019190831.20363-1-quintela@redhat.com>
 <20231019190831.20363-8-quintela@redhat.com>
 <20231019233958.17abb488@bahia> <CWD3OHT178VU.3NF8B5Y5BOK1S@wheely>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 10:33:14 +0200
Message-ID: <87jzrh1ynp.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"Nicholas Piggin" <npiggin@gmail.com> wrote:
> On Fri Oct 20, 2023 at 7:39 AM AEST, Greg Kurz wrote:
>> On Thu, 19 Oct 2023 21:08:25 +0200
>> Juan Quintela <quintela@redhat.com> wrote:


> So the reason we can't have duplicate names registered, aside from it
> surely going bad if we actually send or receive a stream at the point
> they are registered, is the duplcate check introduced in patch 9? But
> before that, this hack does seem to actually work because the duplicate
> is unregistered right away.

You are creating a new general case that has only a single use that you
agree it is "hacky" O:-)

The problem here is that you haven't made your mind what "ipc/server"
means.  You want sometimes to mean pre_2_10, sometimes to mean other
thing.  That is not how this is supposed to work.  See my proposed
change, it is one line change, and just do the right thing.

I know, it breaks backwards compatibility.  But for one machine type
that people are proposing to deprecate/remove.

> If I understand the workaround, there is an asymmetry in the migration
> sequence in that receiving an unexpected object would cause a failure,
> but going from newer to older would just skip some "expected" objects
> and that didn't cause a problem. So you only have to deal with ignoring
> the unexpected ones going form older to newer.


Ok, found a different workaround.
Sending a new version of the series with a different hack that maintains
backwards compatibility.

Later, Juan.



