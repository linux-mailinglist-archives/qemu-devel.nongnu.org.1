Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D5E7F7A48
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 18:23:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Zt4-0000aR-0i; Fri, 24 Nov 2023 12:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Zt1-0000Zd-D0
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:22:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1r6Zsz-0001Ow-UI
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 12:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700846557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GbwVEAyIA/kYKuPaAGC4ZANIWJJ2zj0+CKI2aHaLj38=;
 b=OR1M33rRcEgUZ6EwKrqQKahWvsEvi9cv7Mi2bo25ZnFR41boHs2eXEkm7T5NPy0U7nPNDL
 cEap2jKWmYdTgZBxjbqS9bb/me7FjX7KxsWrfAoup/jh+JXgY1NzZi5xBaZu+I4U89Bh2D
 fn5JZuqshtXvEj+bwLg6e8Ry3kBTjcs=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-Gydfs3WsPCWgPZi7aGbMmQ-1; Fri, 24 Nov 2023 12:22:35 -0500
X-MC-Unique: Gydfs3WsPCWgPZi7aGbMmQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-779f645c74cso210450785a.0
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 09:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700846555; x=1701451355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GbwVEAyIA/kYKuPaAGC4ZANIWJJ2zj0+CKI2aHaLj38=;
 b=alMrIqVlJgvOQuh/7XBizZSyZ6/O6OjNF2qpAtVL5AxDq8X74nIg2+OiKZEVMv0x+o
 0oL+V8lCPvpleMzt6jQ6VJuHVen1KqzOxUEJhU3cvOXaaRaVdvdjXPPKEfD0jHyKihcf
 +hvrKPSIolzsVZhumTGR5gZmZW+MlePAkmRXV614IkwUHmFcJQ0y77NyVPDvVRN4LdiM
 cAiBHAQQsiEd/fJ85Cu55AZo4EAm+AODt/n8A8Fngs4iBCROvQfN5WVN8QeCWQVPNfJm
 Pn4VMQbnEV/XAtyKVK1MirclCGm16HEETrfsIhumKwvAy9IEcb31F8Qx8/LJ/vv2TcxR
 4sWg==
X-Gm-Message-State: AOJu0YzMjYzZ87PbzsK8iuUC88GC8o+7keLir+f6d8M6zU5zRr/dqNdF
 dfkrIhK00uRSTAPgwn3wR+BLuszWyNooOwERlgUqo5DPWQfp8NYahQTFHjnF3xPjpQ5gvn0oMhp
 1FnLYC+gqAsRxA5Q=
X-Received: by 2002:a05:620a:86ce:b0:77d:7349:a094 with SMTP id
 pr14-20020a05620a86ce00b0077d7349a094mr4414889qkn.40.1700846555332; 
 Fri, 24 Nov 2023 09:22:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFu9gI8C1mzYXHLDaf05ipB70ldW31MDqR6tt1DMXjIS1ZSh+AZ+ZhFJr+qxGCExRaz+/MnXA==
X-Received: by 2002:a05:620a:86ce:b0:77d:7349:a094 with SMTP id
 pr14-20020a05620a86ce00b0077d7349a094mr4414846qkn.40.1700846554961; 
 Fri, 24 Nov 2023 09:22:34 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com ([185.140.112.229])
 by smtp.gmail.com with ESMTPSA id
 v20-20020a05620a441400b0077d63e97725sm1370129qkp.95.2023.11.24.09.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 09:22:34 -0800 (PST)
Date: Fri, 24 Nov 2023 18:22:29 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <maz@kernel.org>,
 <jean-philippe@linaro.org>, <jonathan.cameron@huawei.com>,
 <lpieralisi@kernel.org>, <peter.maydell@linaro.org>,
 <richard.henderson@linaro.org>, <andrew.jones@linux.dev>,
 <david@redhat.com>, <philmd@linaro.org>, <eric.auger@redhat.com>,
 <oliver.upton@linux.dev>, <pbonzini@redhat.com>, <mst@redhat.com>,
 <will@kernel.org>, <gshan@redhat.com>, <rafael@kernel.org>,
 <alex.bennee@linaro.org>, <linux@armlinux.org.uk>,
 <darren@os.amperecomputing.com>, <ilkka@os.amperecomputing.com>,
 <vishnu@os.amperecomputing.com>, <karl.heubaum@oracle.com>,
 <miguel.luis@oracle.com>, <salil.mehta@opnsrc.net>,
 <zhukeqian1@huawei.com>, <wangxiongfeng2@huawei.com>,
 <wangyanan55@huawei.com>, <jiakernel2@gmail.com>, <maobibo@loongson.cn>,
 <lixianglai@loongson.cn>, <linuxarm@huawei.com>
Subject: Re: [PATCH V7 0/8] Add architecture agnostic code to support vCPU
 Hotplug
Message-ID: <20231124182229.34dd52cf@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231113201236.30668-1-salil.mehta@huawei.com>
References: <20231113201236.30668-1-salil.mehta@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 13 Nov 2023 20:12:28 +0000
Salil Mehta <salil.mehta@huawei.com> wrote:

> Virtual CPU hotplug support is being added across various architectures[1][3].
> This series adds various code bits common across all architectures:
> 
> 1. vCPU creation and Parking code refactor [Patch 1]
> 2. Update ACPI GED framework to support vCPU Hotplug [Patch 2,3]
> 3. ACPI CPUs AML code change [Patch 4,5]
> 4. Helper functions to support unrealization of CPU objects [Patch 6,7]
> 5. Docs [Patch 8]
[...]

forgot to mention, you probably need to add to series migration code as well
as it should be the same for both targets.
(mostly copy-paste from q35 or piix4 and making sure it doesn't break old qemu
(aka not enabled/sent over wire if cpu hotplug event is disabled))



