Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9064B7CA0E0
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsIC8-0000ot-2C; Mon, 16 Oct 2023 03:39:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsIBu-0000o1-DN
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:39:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsIBr-0007RQ-9g
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:39:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697441942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tGJ97Fejat4piQlLvIpzFv0XYjy3Tca6wBZAkCzzM+w=;
 b=fqJOTsh0IFNDd8abw/12EkfA9xZN1oS0P0+JD+ikdzE+yGXAB9GG21XeZidydRW9OR/e2u
 q4euDxCn9ZQTNJDHPdxLJCzbHAxP6DwQR08+0sI804asp6PmbqR9ox+2w6zLBWMUW4XQgY
 JoS/dRJTPGxyCn0zChBDsOSlgwFlGkA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-MeUPj-7fPiiDFrj1IlxF1w-1; Mon, 16 Oct 2023 03:39:00 -0400
X-MC-Unique: MeUPj-7fPiiDFrj1IlxF1w-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4065478afd3so33366005e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:39:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697441939; x=1698046739;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tGJ97Fejat4piQlLvIpzFv0XYjy3Tca6wBZAkCzzM+w=;
 b=YBQbiu22tU17Fnldhc01hKwyzbyQpXQ/eZ7gAbTOYItatNhvxOIL9BL3o7TI9Zy/0G
 oW01POum0+1xkj/bYBnt9qzrhIAQX3Q1paquiKkuF3cCbOgEf3cxJk0H5IxsGv7CZQCl
 ShjFNXTXakdyzVAoztnV4Lh1tYcavGbFKzVw5WdOxNEuXXKRPfy3W0ZFeU8sT6QT70v4
 4EZB0kpY9p6JlDuc4gWs4Xmmf+Ysc+arPKfTCrw5mBwOmiZ4DA3fD8dN1C6kgcHP55gT
 PAEsLTTnbQSThqn2nK9Z1hCG4P4wTi9CuWBrBUsWNJR+z8q4bC20KfHVM/Hx4firNukP
 eD1Q==
X-Gm-Message-State: AOJu0YwXgzRo8Xj632rCQAHLtNaxRwAEV5qJPUJQC1bwEN/KfnK4/HGW
 FtCVIPgF+Lwz4zDyIG6WfeeUA4qRaZ+qsxAlXnxRD1bx/rn2Hl18Qg3e85WBgZ1CV3MIpKVzuhh
 V3u2aUAYvA5nTb7o=
X-Received: by 2002:a7b:c858:0:b0:404:737a:17d with SMTP id
 c24-20020a7bc858000000b00404737a017dmr27045774wml.9.1697441939467; 
 Mon, 16 Oct 2023 00:38:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB/vY++iEkBwLB3Yj5W43Xa+fK0+soJRLutDdBLEqd3PGsKMjHB/rdb0VwUhiG6Ae3wCCH/g==
X-Received: by 2002:a7b:c858:0:b0:404:737a:17d with SMTP id
 c24-20020a7bc858000000b00404737a017dmr27045758wml.9.1697441939091; 
 Mon, 16 Oct 2023 00:38:59 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 u18-20020adff892000000b00326b8a0e817sm7070566wrp.84.2023.10.16.00.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:38:58 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Nikolay Borisov
 <nborisov@suse.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH RESEND 2/7] migration/ram: Refactor precopy ram loading
 code
In-Reply-To: <20231011184604.32364-3-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 11 Oct 2023 15:45:59 -0300")
References: <20231011184604.32364-1-farosas@suse.de>
 <20231011184604.32364-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 09:38:57 +0200
Message-ID: <87sf6b3tke.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> From: Nikolay Borisov <nborisov@suse.com>
>
> Extract the ramblock parsing code into a routine that operates on the
> sequence of headers from the stream and another the parses the
> individual ramblock. This makes ram_load_precopy() easier to
> comprehend.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>
queued.


