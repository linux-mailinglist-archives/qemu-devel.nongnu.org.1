Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F807FF0AB
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 14:49:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8hOp-0004po-Bk; Thu, 30 Nov 2023 08:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hOc-0004n2-WE
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:48:06 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8hOY-0000oW-Fu
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 08:48:01 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40b4734b975so8784965e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 05:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701352077; x=1701956877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rzryK5Ovxx7DOgDxZdQ36NxzgykTz4w4Mydj5qAA+DE=;
 b=r2Dznn7RVHK1297vRYlqe94iFNeF30YgPKO64YdSm6/dsmRHYdzRHGkTCHoWOssGJO
 /NenS5m8DNkXZRjx093YHfKgYGAb7zUuqwFTjRaU5T+L05q3XiUaNf/topzJqOmGhQ8O
 QsTj7MZZI4gNlxpIycnpacXUnFDfzRtQ2tF1/QbyTfN5690q0Q1MP2r8tH+9hMrhj9Of
 fkxtU8botkYc6WFFghJP3SR1xY9Vr8SqBD7q6XctA9jjJaxdbUp9xONqAirtiCA8E917
 ceprCm5e5Cp2mUL9g+vELobEyBmqriQCgl0viYFMmAhIrCHnMR6mjNPT8uTuf0jEhVBY
 lacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701352077; x=1701956877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rzryK5Ovxx7DOgDxZdQ36NxzgykTz4w4Mydj5qAA+DE=;
 b=flhj1kGQGYQy2uF4pYD7VR3SWCzqtWJNph1NdkGIeV+XWOsxGcD7ogDIQIzMpc/QgQ
 fuWwTQwnLbPCfqUxK6bB3SewJATWmnksyInqKLUSLcCQ2oLjTV94oy2jxUWQYM2drbr5
 vUmZFi6JTW5cT65YzzDvPcy8EWZYGsySUqWqAdwxBiid3q9IiUmfsJvSrGCYO3cKUgiz
 qH9ugiQcrFbZGL3ZJl9NcEij8JREllqTr+sBsBx3xHEDmqZ17DeRlwYo99fV2FJZlEIZ
 gzp7xBCNOf/EpGZcKZvvGP4NZdyQmcWxnhJzuKvojwmqnniOBT+n61rsiDIAA/SOGqxn
 kjcg==
X-Gm-Message-State: AOJu0YyIEwFNURt3Fq8z2iXypKisiDKZvaJvnVTStDQl7gh2W5loMVz3
 BEk3/DvhcPooWleHZNvA6mebkw==
X-Google-Smtp-Source: AGHT+IEVx+BgPGgvtoGgXlS2ma7+soUtQpvgW6i96U/5dPN3399XP3o/9uLj4S+iHyFoPGNahzok1g==
X-Received: by 2002:a05:600c:3c8a:b0:40b:4da4:b985 with SMTP id
 bg10-20020a05600c3c8a00b0040b4da4b985mr6336852wmb.38.1701352076590; 
 Thu, 30 Nov 2023 05:47:56 -0800 (PST)
Received: from [192.168.69.100] (sev93-h02-176-184-17-116.dsl.sta.abo.bbox.fr.
 [176.184.17.116]) by smtp.gmail.com with ESMTPSA id
 n26-20020a05600c3b9a00b0040b34409d43sm2099005wms.11.2023.11.30.05.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Nov 2023 05:47:56 -0800 (PST)
Message-ID: <9c305a84-fd86-42fe-98ae-9297d480acd6@linaro.org>
Date: Thu, 30 Nov 2023 14:47:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] Replace "iothread lock" with "BQL" in comments
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>, Paul Durrant <paul@xen.org>,
 Jagannathan Raman <jag.raman@oracle.com>, Juan Quintela
 <quintela@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-arm@nongnu.org, Jason Wang
 <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Huacai Chen <chenhuacai@kernel.org>,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 Jiri Slaby <jslaby@suse.cz>, Alexander Graf <agraf@csgraf.de>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Stafford Horne <shorne@gmail.com>,
 David Hildenbrand <david@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Cameron Esfahani <dirty@apple.com>, xen-devel@lists.xenproject.org,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 John Snow <jsnow@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Roth <michael.roth@amd.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bin.meng@windriver.com>,
 Stefano Stabellini <sstabellini@kernel.org>, kvm@vger.kernel.org,
 qemu-block@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Anthony Perard <anthony.perard@citrix.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Leonardo Bras
 <leobras@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20231129212625.1051502-1-stefanha@redhat.com>
 <20231129212625.1051502-6-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231129212625.1051502-6-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Stefan,

On 29/11/23 22:26, Stefan Hajnoczi wrote:
> The term "iothread lock" is obsolete. The APIs use Big QEMU Lock (BQL)
> in their names. Update the code comments to use "BQL" instead of
> "iothread lock".
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   docs/devel/reset.rst             |  2 +-
>   hw/display/qxl.h                 |  2 +-
>   include/exec/cpu-common.h        |  2 +-
>   include/exec/memory.h            |  4 ++--
>   include/exec/ramblock.h          |  2 +-
>   include/migration/register.h     |  8 ++++----
>   target/arm/internals.h           |  4 ++--
>   accel/tcg/cputlb.c               |  4 ++--
>   accel/tcg/tcg-accel-ops-icount.c |  2 +-
>   hw/remote/mpqemu-link.c          |  2 +-
>   migration/block-dirty-bitmap.c   | 10 +++++-----
>   migration/block.c                | 24 ++++++++++++------------
>   migration/colo.c                 |  2 +-
>   migration/migration.c            |  2 +-
>   migration/ram.c                  |  4 ++--
>   system/physmem.c                 |  6 +++---
>   target/arm/helper.c              |  2 +-
>   target/arm/tcg/m_helper.c        |  2 +-
>   ui/spice-core.c                  |  2 +-
>   util/rcu.c                       |  2 +-
>   audio/coreaudio.m                |  4 ++--
>   ui/cocoa.m                       |  6 +++---
>   22 files changed, 49 insertions(+), 49 deletions(-)


> diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
> index 69c6a53902..a2bc0a345d 100644
> --- a/include/exec/ramblock.h
> +++ b/include/exec/ramblock.h
> @@ -34,7 +34,7 @@ struct RAMBlock {
>       ram_addr_t max_length;
>       void (*resized)(const char*, uint64_t length, void *host);
>       uint32_t flags;
> -    /* Protected by iothread lock.  */
> +    /* Protected by BQL.  */

There is only one single BQL, so preferably:

"by the BQL"

>       char idstr[256];
>       /* RCU-enabled, writes protected by the ramlist lock */
>       QLIST_ENTRY(RAMBlock) next;




> -/* Called with iothread lock taken.  */
> +/* Called with BQL taken.  */

"with the BQL" (other uses)

Otherwise,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   static void dirty_bitmap_do_save_cleanup(DBMSaveState *s)
>   {
>       SaveBitmapState *dbms;
> @@ -479,7 +479,7 @@ static void dirty_bitmap_do_save_cleanup(DBMSaveState *s)
>       }
>   }


