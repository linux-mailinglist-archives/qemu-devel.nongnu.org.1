Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5329F7CF65A
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 13:12:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQx5-0003VJ-RX; Thu, 19 Oct 2023 07:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQx1-0003V5-88
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtQwz-0003Wu-LY
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697713944;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=r9GRhJNUeoPy0aH4gr/ADbKHy/OCTm6Koa4Z8VwIt8E=;
 b=FcMXLuLa3exalg33qFcWhRRNIHpGe6KLzeAo1d8FrHfvYJlIGeDPF45ZfPqD/Jj0R9Jd/T
 YVUe4Vpah5p6VUIjKoLYjhcBKxcW5VBxJSfwJfT+L3GLsnFNqHPhIdYjoMLrN2nEJzm2Ty
 5xNVJguWT3wy/TcQ5VwoWbBqkb6iVeg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-cZqPzQPPPoGB7kmA1LyoHg-1; Thu, 19 Oct 2023 07:12:23 -0400
X-MC-Unique: cZqPzQPPPoGB7kmA1LyoHg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408374a3d6bso13488135e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:12:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697713942; x=1698318742;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r9GRhJNUeoPy0aH4gr/ADbKHy/OCTm6Koa4Z8VwIt8E=;
 b=IcruxIfliM0I3trVAKySjK9xC7vr1mbiGxrQX3R4t681hxwCAjp53gld0OOk6N89y7
 RxJA1ToWAGRUmopJzKSsZRigxuXdFG9nzvBsXsK4GM+c2xcJzh7X+XCNvVE7An4/ijnv
 FB5GbJhT8gSOowfcaLPN7tPBXVkiw5cERhuW4UgrPhnFYfPP8ENvB6KZ8uZe64l/y7Pe
 HaB6czgn0WpjGPxPNxCodxkKxyf5QuKguYSkjtaJAb+H9KAvNySbAtcDuWM1yl+A12Ue
 Ef+E14+v6ZXdiegi/Afo6pqlBguM8UaThauIk2jxNxo7pS7aYfqgTIgUV1nQIeNagwMh
 Iqhg==
X-Gm-Message-State: AOJu0YzfHk1ERLyxAfgUfG+xIM0kowh3Ro/M4Lpp59hfX4imCk4a7xey
 MXtSB3JprQjAg8Vd82sDRkZ6xwVK2ow2VwFrfrhLeM82em/dV5cTbaEHsLifzr4NxsavrsYL7uA
 kWxLdW+xnIn5T4V0=
X-Received: by 2002:a05:600c:1c8d:b0:406:478e:9e2d with SMTP id
 k13-20020a05600c1c8d00b00406478e9e2dmr1470791wms.26.1697713942388; 
 Thu, 19 Oct 2023 04:12:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhq98rHCwv+EI+s6MLNFVNS9GdNs1MASeN42GCbdgxQaWeK1oUosedvhKPuLYv89bDpyBLPg==
X-Received: by 2002:a05:600c:1c8d:b0:406:478e:9e2d with SMTP id
 k13-20020a05600c1c8d00b00406478e9e2dmr1470776wms.26.1697713942020; 
 Thu, 19 Oct 2023 04:12:22 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t13-20020a05600c450d00b0040651505684sm4201060wmo.29.2023.10.19.04.12.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:12:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org,  nanhai.zou@intel.com
Subject: Re: [PATCH 1/5] configure: add qpl meson option
In-Reply-To: <20231018221224.599065-2-yuan1.liu@intel.com> (Yuan Liu's message
 of "Thu, 19 Oct 2023 06:12:20 +0800")
References: <20231018221224.599065-1-yuan1.liu@intel.com>
 <20231018221224.599065-2-yuan1.liu@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:12:20 +0200
Message-ID: <8734y67tnv.fsf@secure.mitica>
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

Yuan Liu <yuan1.liu@intel.com> wrote:
> Intel Query Processing Library (QPL) is an open-source library that
> supports features of the new Intel In-Memory Analytics Accelerator (IAA)
> available on Intel Xeon Sapphire Rapids processors, including
> high-throughput compression and decompression.
>
> add --enable-qpl and --disable-qpl options for data (de)compression
> using IAA during the live migration process.
>
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
> @@ -2158,6 +2163,7 @@ config_host_data.set('CONFIG_MALLOC_TRIM', has_malloc_trim)
>  config_host_data.set('CONFIG_STATX', has_statx)
>  config_host_data.set('CONFIG_STATX_MNT_ID', has_statx_mnt_id)
>  config_host_data.set('CONFIG_ZSTD', zstd.found())
> +config_host_data.set('CONFIG_QPL', qpl.found())
>  config_host_data.set('CONFIG_FUSE', fuse.found())
>  config_host_data.set('CONFIG_FUSE_LSEEK', fuse_lseek.found())
>  config_host_data.set('CONFIG_SPICE_PROTOCOL', spice_protocol.found())
> @@ -3616,7 +3622,7 @@ libmigration = static_library('migration', sources: migration_files + genh,
>                                name_suffix: 'fa',
>                                build_by_default: false)
>  migration = declare_dependency(link_with: libmigration,
> -                               dependencies: [zlib, qom, io])
> +                               dependencies: [zlib, qom, io, qpl])

I think this is wrong.  Look how zstd is done.

You need to add something like this:

system_ss.add(when: zstd, if_true: files('multifd-zstd.c'))

to migration/meson.build

Or asking this other way, does this works if qpl is not there?  Or if
you compile for anything that is not x86?

Later, Juan.


