Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6327B72C4
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 22:51:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmMQ-0006ww-Hx; Tue, 03 Oct 2023 16:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmML-0006pd-9X
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:51:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qnmMJ-0005ZC-WD
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 16:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696366271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uZCbYPj7LvT/ja2YMVChr5AS8uWamVe2VVShdtE2YSI=;
 b=UjwHJUDa62IhTrWtLmz4kHZdyqATCI3mc4ZsyDDMlbwRUJhQ/m6DCRrOFN5sCxoTMScNCP
 dfHqxSVd9/paPyOwetDrEzVR73HoBNBk1BBuezelkltpENRqc88KHwZaQqqAbtZRfRXG52
 9lGzDIBqjt4lATEsOnDDadiU5mFw4uY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-CHeEyXgtMMe8Fk80T4ZICg-1; Tue, 03 Oct 2023 16:51:09 -0400
X-MC-Unique: CHeEyXgtMMe8Fk80T4ZICg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7742bd869e4so28239985a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 13:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696366269; x=1696971069;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uZCbYPj7LvT/ja2YMVChr5AS8uWamVe2VVShdtE2YSI=;
 b=IYOGq2SxqlCjaAh7bPUNDxiWxqqpos1ujMqDiilW+zXFsQcsnF20sc1A1sEzdmKKUU
 ACLQGx6pitaNEKouheNBzDZBAiysvyPm0SVYZxssjfudncCryjdIimas2dng5f6eJzVI
 Xv+nWnZYNSBvp1LAAlKwb04w3RU1rzJjXMer5J8Kio+wQu9GXgNQUg2BTW0PNEtSwudZ
 E8B1MRc3ZykQO5nCHKDnVZrsJ/2LEpYLuArHZMUwCKmCFF5MngYITkZ4NRLq5Sa16wJ3
 6WLY3tabUaoXnveOdPYnVHLW2liPlQYZrtxagt0XlB5Q6G+5GtF45mKJ2wpmELjYA/jg
 0MrQ==
X-Gm-Message-State: AOJu0YxrhPqBbXRXSGx5z2I7E935zCZW8wcpC4BUsNfBjWUkNuSjSep5
 g7kGcrg24UFPTO8ua7M8FiW0bXYcsG/fKDbeFBHyGrxVPZtfjBVo+Ls0JTwqrnV6dnXQqY5AgHb
 eu/kb0zOYFg1GyuI=
X-Received: by 2002:a05:620a:4623:b0:773:a70e:a4c4 with SMTP id
 br35-20020a05620a462300b00773a70ea4c4mr695859qkb.6.1696366269139; 
 Tue, 03 Oct 2023 13:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5mNmgPDUnY0hPhDFdYQlP1C5buz63f/EaH1GckPFIuP8u8FPURc8O9lxL48lKIEI2Fvkikg==
X-Received: by 2002:a05:620a:4623:b0:773:a70e:a4c4 with SMTP id
 br35-20020a05620a462300b00773a70ea4c4mr695847qkb.6.1696366268827; 
 Tue, 03 Oct 2023 13:51:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c12-20020a05620a134c00b00774652483b7sm759035qkl.33.2023.10.03.13.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 13:51:08 -0700 (PDT)
Date: Tue, 3 Oct 2023 16:51:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/5] hw/i386/apic: Simplify apic_get_class()
Message-ID: <ZRx+uo9PBQZryC9j@x1n>
References: <20231003082728.83496-1-philmd@linaro.org>
 <20231003082728.83496-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231003082728.83496-4-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Oct 03, 2023 at 10:27:26AM +0200, Philippe Mathieu-Daudé wrote:
> Now than apic_get_class() can not fail, remove its
> Error** parameter. It can't return NULL neither, so
> simplify x86_cpu_apic_create().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


