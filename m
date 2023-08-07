Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D2C771DC9
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 12:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSxD9-0007zb-82; Mon, 07 Aug 2023 06:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qSxD6-0007zS-S7
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qSxD5-0000LZ-Am
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691403093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1E20khcjHM9VwhHWKPgXyzeWZ+W/3koIC8uQoUdp8po=;
 b=D/Nim+JslV/q6H80Wv13KN36lHYXmNfjEhVvBVfi7cwrTETqCIJ2NHO1Nx6esFpcbs4ulX
 7uqwJzkhonDOd4bf/19xOkVn6JSG+9MXDA1j0D7I4e2CZr+726UmqtkcsHHQ8oZ5VsUTgH
 y6bwLB1bXhPqlr4PdwPbrNcXRlu/JZ0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-AnBgWpRfNQKvxBIdiiXHfw-1; Mon, 07 Aug 2023 06:11:32 -0400
X-MC-Unique: AnBgWpRfNQKvxBIdiiXHfw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso319930166b.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 03:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691403091; x=1692007891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1E20khcjHM9VwhHWKPgXyzeWZ+W/3koIC8uQoUdp8po=;
 b=TbvmtcjGiAKjfk4g9fy8AO04a8NDLn1Upisd8TSsAaItgPk/9R5pag6ogtFRhtbjgk
 QtHB7ufpTScms+gjJbadO53qWmVSaw8/uFZLakgyD/s4r5F9oZyGtdH1UCed3vOVxHIU
 rt/jeuntBWT0dEhbGwJ7EXmDZORhk1AITAnPoy89zVkN2EqqYm4lM/OBmnjlqFV1nXoK
 XNfBGeecu/VUvTyfv2cqHpGDzaK8Vw8u39s95FkWlt89rASnjSFa5e7UMOmjmoJm6T13
 9CMPK0N0n5tP55XOwKOLfA5/IamVoUgWmfoW8LCVDLOK4SkB4HpcsaKz0Hna0Ap2+mbu
 uang==
X-Gm-Message-State: AOJu0Yx9qqwTHIowHfUZdQDjj6fqVib9NMAs6AuSAsNO38aHgvCEh4BH
 o8yo6RKgmo9YroE4mFTS2gAIWE+azDKhIR06Eyw3JpeTN0qIU1zKv8VNKIKBUur2eqGg2sNjsMk
 X9hEJG7PYnKis/Lg=
X-Received: by 2002:a17:906:30cf:b0:973:fd02:a41f with SMTP id
 b15-20020a17090630cf00b00973fd02a41fmr8995089ejb.40.1691403091115; 
 Mon, 07 Aug 2023 03:11:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTFV1WxlyqhEhDS+gAPoHLhh9qytIkkjRrtck3EnI8EgAxjuLGfKZTYtJAOUvC9tNJoqzQbw==
X-Received: by 2002:a17:906:30cf:b0:973:fd02:a41f with SMTP id
 b15-20020a17090630cf00b00973fd02a41fmr8995075ejb.40.1691403090872; 
 Mon, 07 Aug 2023 03:11:30 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 h15-20020a1709066d8f00b00997e52cb30bsm4941515ejt.121.2023.08.07.03.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 03:11:30 -0700 (PDT)
Date: Mon, 7 Aug 2023 12:11:29 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Zhao Liu <zhao1.liu@linux.intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH v2 2/3] hw/smbios: Fix thread count in type4
Message-ID: <20230807121129.30e6fe1e@imammedo.users.ipa.redhat.com>
In-Reply-To: <ddfe932b-57b7-8f48-03aa-82e1964dda2a@tls.msk.ru>
References: <20230601092952.1114727-1-zhao1.liu@linux.intel.com>
 <20230601092952.1114727-3-zhao1.liu@linux.intel.com>
 <598990ac-e5f8-fdcc-5936-e219491c4d0f@tls.msk.ru>
 <32cfa897-4472-083f-88cd-a3c3e3c405b0@tls.msk.ru>
 <20230807115615.278fb838@imammedo.users.ipa.redhat.com>
 <ddfe932b-57b7-8f48-03aa-82e1964dda2a@tls.msk.ru>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 7 Aug 2023 13:06:47 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> 07.08.2023 12:56, Igor Mammedov wrote:
> > On Sat, 5 Aug 2023 09:00:41 +0300
> > Michael Tokarev <mjt@tls.msk.ru> wrote:
[...]
> The whole thing - provided the preparational patch a1d027be95
> "machine: Add helpers to get cores/threads per socket" is also
> picked up - applies cleanly and in a stright-forward way to 8.0
> and even to 7.2, and passes the usual qemu testsuite. Sure thing
> since the issues weren't noticed before, the testsuite does not
> cover this area.  It'd be nice to have some verifier to check if
> the whole thing actually works after applying the patchset.

Zhao Liu,
can you help us out with adding test cases to cover the code
you are touching?

[...]


