Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 169E8827F03
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 08:05:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN6AJ-0001FS-Hk; Tue, 09 Jan 2024 02:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6AF-0001F1-Rn
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:04:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rN6A0-0005Ah-7g
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 02:04:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704783866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W4VAC9NkJYcrijnttf0sTEJDhxz94jisTbviBsmNMt0=;
 b=T1sn3qxfYZdj8hqDh2Sgwnm+9HcSSEMD3r8ks72KikWl81GC+CosDo7bnmpCHq4TyuDNQp
 MDYPoIhiUa2WomyNOzE1REbcMlM+ylxcD8UdYHDK3VQ8wLR96MEGcdAuZ2zlP4DHpYIcNB
 f0fN/why3jRG7ebVtU8W45h5j6AMNGE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-xRJIrlgsNoG2LDfCSdzHeg-1; Tue, 09 Jan 2024 02:04:25 -0500
X-MC-Unique: xRJIrlgsNoG2LDfCSdzHeg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4298fd8a48bso29616981cf.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 23:04:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704783864; x=1705388664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W4VAC9NkJYcrijnttf0sTEJDhxz94jisTbviBsmNMt0=;
 b=Lml/y8f3X1sGnI189uNhS7ckKj/12ANF9EzTalQzEJ6dYe4J8KHizCV4JeXF0MnwyU
 lFqytM1A8PR1ib7uzdTfCJ1BMHKM65dWs5IPL3Q5xacDYda3fzuvhCAoqxu3yCItUNsy
 OCGrOu5t/5BEJg3SWoQlKGaCF//+Z5T8NSwnQYmOMUBnTAoxVcCHUmZ3renpGiYDXZy/
 wifAYO5ucrf0ypzpxnHfvpXFQRLU8KXt5x7vjryANqKjFdpmLPBdY6JAHcjJwe49Ycox
 mkzybb4iV5bM0P0DgpxWbQtadiv4ccMRUuqauZ2Vz0dxXdca1yXjCk+fun0c7E1ALump
 1Y0Q==
X-Gm-Message-State: AOJu0YzFSB+2jW8hEIE1p5ejBN9RmNceUJDRHHQbxDuquQizM7Fqmx93
 dp7NqMW8UgjRirV7kpSeRcJ8FllStrA9Rc+CdDKPk08wLklkIAnm/jS2vw7DUI4Jgdw2/At0TIf
 YFXwuHg5Q/S2+i7r4/AlhsOs=
X-Received: by 2002:a05:622a:5983:b0:429:7fd5:784c with SMTP id
 gb3-20020a05622a598300b004297fd5784cmr6355342qtb.78.1704783864591; 
 Mon, 08 Jan 2024 23:04:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEexR/qne6iSwDUI09tCB4c1ZBqtX7k+z04GvCYio/b4joPOWRY1Cnz9f6g47y58pfG/zK+5Q==
X-Received: by 2002:a05:622a:5983:b0:429:7fd5:784c with SMTP id
 gb3-20020a05622a598300b004297fd5784cmr6355334qtb.78.1704783864343; 
 Mon, 08 Jan 2024 23:04:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 cr14-20020a05622a428e00b0042997333149sm605370qtb.63.2024.01.08.23.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 23:04:24 -0800 (PST)
Message-ID: <7a561c8e-300f-465c-9bcb-91b644a9a7b8@redhat.com>
Date: Tue, 9 Jan 2024 08:04:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] docs/migration: Split "Debugging" and "Firmware"
Content-Language: en-US
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bandan Das <bdas@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240109064628.595453-1-peterx@redhat.com>
 <20240109064628.595453-6-peterx@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240109064628.595453-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 1/9/24 07:46, peterx@redhat.com wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> Move the two sections into a separate file called "best-practises.rst".
> Add the entry into index.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   docs/devel/migration/best-practises.rst | 48 +++++++++++++++++++++++++
>   docs/devel/migration/index.rst          |  1 +
>   docs/devel/migration/main.rst           | 44 -----------------------
>   3 files changed, 49 insertions(+), 44 deletions(-)
>   create mode 100644 docs/devel/migration/best-practises.rst
> 
> diff --git a/docs/devel/migration/best-practises.rst b/docs/devel/migration/best-practises.rst
> new file mode 100644
> index 0000000000..ba122ae417
> --- /dev/null
> +++ b/docs/devel/migration/best-practises.rst
> @@ -0,0 +1,48 @@
> +==============
> +Best practises
> +==============
> +
> +Debugging
> +=========
> +
> +The migration stream can be analyzed thanks to ``scripts/analyze-migration.py``.
> +
> +Example usage:
> +
> +.. code-block:: shell
> +
> +  $ qemu-system-x86_64 -display none -monitor stdio
> +  (qemu) migrate "exec:cat > mig"
> +  (qemu) q
> +  $ ./scripts/analyze-migration.py -f mig
> +  {
> +    "ram (3)": {
> +        "section sizes": {
> +            "pc.ram": "0x0000000008000000",
> +  ...
> +
> +See also ``analyze-migration.py -h`` help for more options.
> +
> +Firmware
> +========
> +
> +Migration migrates the copies of RAM and ROM, and thus when running
> +on the destination it includes the firmware from the source. Even after
> +resetting a VM, the old firmware is used.  Only once QEMU has been restarted
> +is the new firmware in use.
> +
> +- Changes in firmware size can cause changes in the required RAMBlock size
> +  to hold the firmware and thus migration can fail.  In practice it's best
> +  to pad firmware images to convenient powers of 2 with plenty of space
> +  for growth.
> +
> +- Care should be taken with device emulation code so that newer
> +  emulation code can work with older firmware to allow forward migration.
> +
> +- Care should be taken with newer firmware so that backward migration
> +  to older systems with older device emulation code will work.
> +
> +In some cases it may be best to tie specific firmware versions to specific
> +versioned machine types to cut down on the combinations that will need
> +support.  This is also useful when newer versions of firmware outgrow
> +the padding.
> diff --git a/docs/devel/migration/index.rst b/docs/devel/migration/index.rst
> index 7fc02b9520..c09623b38f 100644
> --- a/docs/devel/migration/index.rst
> +++ b/docs/devel/migration/index.rst
> @@ -11,3 +11,4 @@ QEMU live migration works.
>      compatibility
>      vfio
>      virtio
> +   best-practises
> diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
> index b3e31bb52f..97811ce371 100644
> --- a/docs/devel/migration/main.rst
> +++ b/docs/devel/migration/main.rst
> @@ -52,27 +52,6 @@ All these migration protocols use the same infrastructure to
>   save/restore state devices.  This infrastructure is shared with the
>   savevm/loadvm functionality.
>   
> -Debugging
> -=========
> -
> -The migration stream can be analyzed thanks to ``scripts/analyze-migration.py``.
> -
> -Example usage:
> -
> -.. code-block:: shell
> -
> -  $ qemu-system-x86_64 -display none -monitor stdio
> -  (qemu) migrate "exec:cat > mig"
> -  (qemu) q
> -  $ ./scripts/analyze-migration.py -f mig
> -  {
> -    "ram (3)": {
> -        "section sizes": {
> -            "pc.ram": "0x0000000008000000",
> -  ...
> -
> -See also ``analyze-migration.py -h`` help for more options.
> -
>   Common infrastructure
>   =====================
>   
> @@ -970,26 +949,3 @@ the background migration channel.  Anyone who cares about latencies of page
>   faults during a postcopy migration should enable this feature.  By default,
>   it's not enabled.
>   
> -Firmware
> -========
> -
> -Migration migrates the copies of RAM and ROM, and thus when running
> -on the destination it includes the firmware from the source. Even after
> -resetting a VM, the old firmware is used.  Only once QEMU has been restarted
> -is the new firmware in use.
> -
> -- Changes in firmware size can cause changes in the required RAMBlock size
> -  to hold the firmware and thus migration can fail.  In practice it's best
> -  to pad firmware images to convenient powers of 2 with plenty of space
> -  for growth.
> -
> -- Care should be taken with device emulation code so that newer
> -  emulation code can work with older firmware to allow forward migration.
> -
> -- Care should be taken with newer firmware so that backward migration
> -  to older systems with older device emulation code will work.
> -
> -In some cases it may be best to tie specific firmware versions to specific
> -versioned machine types to cut down on the combinations that will need
> -support.  This is also useful when newer versions of firmware outgrow
> -the padding.


