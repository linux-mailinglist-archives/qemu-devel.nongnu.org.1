Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7EC7DCE29
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:48:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxp6B-0004nZ-Mx; Tue, 31 Oct 2023 09:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxp6A-0004nQ-Jm
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:48:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxp65-0007AE-TK
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698760077;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vpO58N4VXOewaUkkUBxKVBMT7ouBiWkXiBmsGuBaW+s=;
 b=d3bUVIlIWKkbBxgMrc6MKS7XnjBcktbddw7pe4iVYuGK5a9rlI718LpnEYH2qUdgmDMzs8
 VGbUSX5gRZrq/oLMbURyyZSC68PqFjcBuEVJss9LPTqLMlTKL1DdZZbjhIh5q2aCXgyU1c
 kw03XRAMAb8t+/gGc5Vu8nLyfjaS94Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-YZmyebB7OAurWJSWPUJdHg-1; Tue, 31 Oct 2023 09:47:55 -0400
X-MC-Unique: YZmyebB7OAurWJSWPUJdHg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4083865e0b7so39577415e9.3
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698760074; x=1699364874;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpO58N4VXOewaUkkUBxKVBMT7ouBiWkXiBmsGuBaW+s=;
 b=vu7hCrepJuEu6tgTsNQK0UOt1PMLwH1GC1SOXcwKLQCVCLJOLly3RUnK4Zr14+6VfV
 NjeF/Ou6BOgut+fv4Zta9oAVW4yE6geuRvvWcXze6qZNqpAK0JZeeRZTKMy7JaM3tP3U
 4bY/jxHafNU60wYv4813u3E5wReFRkuVG8SFi0bpc1VTZsLZUjE6tBeeLlExpQYBO4iy
 YwsbgTSytcmkuOFTDrwlZBNbf0f/xlJ8wV/SodcfY6NpX9g0o3gjUwbjFDVyVNmSwRil
 355baq/2Zv1Obi+oJGs4cpiHGoFSp8qEfYZvVu5Mrs+WaIkKdC1TPx5eTRBBRLbVh/74
 moSw==
X-Gm-Message-State: AOJu0YyuCqfPyDZyAWv7QR3o2+SqkyBJK6xJsIwryheKjeTHiYx62MTC
 TpUXVTiV8a7JZy4rvN5UxiLUm0HGlvJn6/wy62ZVDkEhyxw9uulzqxw8SrQxnOzKpXhDcoLSVRl
 zfZa+HRH6OiacMcc=
X-Received: by 2002:a05:600c:1992:b0:406:53c0:3c71 with SMTP id
 t18-20020a05600c199200b0040653c03c71mr10892763wmq.37.1698760074620; 
 Tue, 31 Oct 2023 06:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/5Antl//cPHYzbdiC6f4FkS2o8CkKpbx1f0VbQbnyLPs2PRSM+odOB3qXkucCcM3OyRIE7A==
X-Received: by 2002:a05:600c:1992:b0:406:53c0:3c71 with SMTP id
 t18-20020a05600c199200b0040653c03c71mr10892747wmq.37.1698760074264; 
 Tue, 31 Oct 2023 06:47:54 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 g12-20020a05600c310c00b003fe1fe56202sm1784458wmo.33.2023.10.31.06.47.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:47:53 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 1/5] migration: Refactor error handling in source
 return path
In-Reply-To: <20231017202633.296756-2-peterx@redhat.com> (Peter Xu's message
 of "Tue, 17 Oct 2023 16:26:29 -0400")
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-2-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 31 Oct 2023 14:47:52 +0100
Message-ID: <87msvy7vjr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Peter Xu <peterx@redhat.com> wrote:
> rp_state.error was a boolean used to show error happened in return path
> thread.  That's not only duplicating error reporting (migrate_set_error),
> but also not good enough in that we only do error_report() and set it to
> true, we never can keep a history of the exact error and show it in
> query-migrate.
>
> To make this better, a few things done:
>
>   - Use error_setg() rather than error_report() across the whole lifecycle
>     of return path thread, keeping the error in an Error*.
>
>   - With above, no need to have mark_source_rp_bad(), remove it, alongside
>     with rp_state.error itself.
>
>   - Use migrate_set_error() to apply that captured error to the global
>     migration object when error occured in this thread.
>
>   - Do the same when detected qemufile error in source return path
>
> We need to re-export qemu_file_get_error_obj() to do the last one.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Patch is really long.
And you stated in the commit how to split it to make it more "digestable".


