Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E42786153
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuMS-00050M-Kj; Wed, 23 Aug 2023 16:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuMQ-0004z3-HD
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuMO-0005CA-6J
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692822106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AnjiGDCYk450h7wNl+QfgTrcQ/TdbYEkyZaVRRAgj28=;
 b=PDATbvY491/TOjdtERhFj0YoMAcWv2CTCMpHc3pZGp4lOzExGxROFAtmigQ1rOhsGCLIbu
 CoRWg6sbSKaGsI4ENp6K0tj2nfvWuU14JNic1fzTtgmSuoEx07iKpLJgbSDhJTskS4valv
 PSpjpNYeF58B2bKlapOPvYMh6MmLbUY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-W171YpJ6NPCt8rk6MtjHGg-1; Wed, 23 Aug 2023 16:21:45 -0400
X-MC-Unique: W171YpJ6NPCt8rk6MtjHGg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76daf02760dso57293785a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822104; x=1693426904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AnjiGDCYk450h7wNl+QfgTrcQ/TdbYEkyZaVRRAgj28=;
 b=Zg37ayntnsxvfJbWBaDicVcohGOjokzoEwOwgZdopZcMtUMTG4wPrORtoXfzGrIcWx
 PP0ye6DzJWT/lHNhhgdqGpmoN5OqnsDe5P2VSBY16XbUl+G2pasIyd+E2UOeMoSIsF/m
 dQZJnTKoITfRVEIdh8xJv7bRENwymgQuI6bXwNJXdyqYXAR2DR/q0tEXOIaA8gvTQg7N
 yQ+hhkQHt8EAcgWWwKswf510LoSrY4NMvn78e4mzBmCBsYIeuwDz2dGiSQclSiPYQq2c
 SetWGohktCb5V6rh762NWt3oJCDe6KGaKjGBMkYeygWejxmPTba6E72onkHwDtftkemB
 Tzqw==
X-Gm-Message-State: AOJu0Yy9iVy8MDZITvls7o9o8Cw5faJD4z/DycGiXeE79xawTSxbcoZv
 iVefw/EdA246XFnWD4ZceBFGNjK9JimGG0KN2bHIZBBIbhzd6+fev7X8p5ZxnNqKJoPAH4zFsFM
 XiX1TREJvGIZq04w=
X-Received: by 2002:a05:620a:1786:b0:76d:1339:e871 with SMTP id
 ay6-20020a05620a178600b0076d1339e871mr16732468qkb.5.1692822104684; 
 Wed, 23 Aug 2023 13:21:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE+DYQmWQufT3a9klxWcTNO4gT8e/PrDwMaBTg+bazfE5/ym/Vp+I8VeNU+OOck0szyw1qJA==
X-Received: by 2002:a05:620a:1786:b0:76d:1339:e871 with SMTP id
 ay6-20020a05620a178600b0076d1339e871mr16732457qkb.5.1692822104464; 
 Wed, 23 Aug 2023 13:21:44 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05620a121100b0076da620166bsm2497662qkj.103.2023.08.23.13.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:21:44 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:21:42 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 04/11] softmmu/physmem: Remap with proper protection
 in qemu_ram_remap()
Message-ID: <ZOZqVrG58M9fexle@x1n>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-5-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823153412.832081-5-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 23, 2023 at 05:34:04PM +0200, David Hildenbrand wrote:
> Let's remap with the proper protection that we can derive from
> RAM_READONLY.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


