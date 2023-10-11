Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A317C554E
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 15:24:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqZBv-00069T-0f; Wed, 11 Oct 2023 09:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZBs-00069J-B2
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:23:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqZBq-0004LV-OO
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 09:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697030633;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=shaAaqZtTKf8RsjYHcmKT+fatTxAtORxo5gOBvo1ptQ=;
 b=IePDDonLAlw9o7gQ8st+taN3Oz8WIqqC3s0rkZNKPO39vF6qPB+C26dal5eGtky7OK4uEx
 RkiXwV3az6iceqWOkuPm0dxGputJHj3D19/Q52VrQwYm4vFpWpwjIwkZLcdKGYJ8OfFXoW
 rA4CPdBNyQp0SeWLJVvuhy3hihT60ME=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-oW7ogxbNO9ahkIvFtETPAg-1; Wed, 11 Oct 2023 09:23:52 -0400
X-MC-Unique: oW7ogxbNO9ahkIvFtETPAg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4065478afd3so44821215e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 06:23:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697030630; x=1697635430;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=shaAaqZtTKf8RsjYHcmKT+fatTxAtORxo5gOBvo1ptQ=;
 b=LgOVbbQZX0IbHdLTdTsXR3orhzkkf6G5dVQre/LF7INZVqZJh3zH+1OGM3glBQecqr
 3Ow2MHcvFKSRtpv1vHatjcpZd4ezY7T4KP6l80CSYsfQI+7mzG06mTcoNh/AEHtGjtb5
 0kFoueG7EXCxu6Wgp4jLPjR2Q297zGYOpQcRRyv5Pd1To51KrYKxJl9Wkpe3SJTYAdV1
 eo0jLXfA+PayMcGR5zLqB/n113mv55COEQ1dcmnIYYDlcXtLuxUAFa0faXmQuS9W+mHL
 5cKiCqlWQyYTK/UO6I75Nv4OgxjMcEsawBw0GdK2bivcKsckncpfFgcVx51xlqnD/Sl1
 OvgA==
X-Gm-Message-State: AOJu0YzLU0Lsy1NELDRb3qSo3TpfqdzK+zIbeqIFx/9gfYY4TCrvQMMO
 mGiCs3BwWl/CL6CO64SfDD+Gqt5lCFqXY3OI8P9pxhdr1lJmLp487mAaQxbATGd0G1a4S/ntyIx
 DOYuxK31mqLGBFnE=
X-Received: by 2002:a05:600c:3502:b0:406:44e6:c00d with SMTP id
 h2-20020a05600c350200b0040644e6c00dmr19039200wmq.2.1697030630237; 
 Wed, 11 Oct 2023 06:23:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr+YSVhUGTpue759pYYqXwS2e0lClOiKqCl/d6nglBUi0GUxglyrduDFsYjpO7YmEPaCC1zA==
X-Received: by 2002:a05:600c:3502:b0:406:44e6:c00d with SMTP id
 h2-20020a05600c350200b0040644e6c00dmr19039186wmq.2.1697030629891; 
 Wed, 11 Oct 2023 06:23:49 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 10-20020a05600c228a00b004065d72ab19sm19273663wmf.0.2023.10.11.06.23.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 06:23:49 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  John Snow <jsnow@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 4/6] migration: Fix analyze-migration.py when
 ignore-shared is used
In-Reply-To: <20231009184326.15777-5-farosas@suse.de> (Fabiano Rosas's message
 of "Mon, 9 Oct 2023 15:43:24 -0300")
References: <20231009184326.15777-1-farosas@suse.de>
 <20231009184326.15777-5-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 15:23:48 +0200
Message-ID: <87v8bd9tsr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> The script is currently broken when the x-ignore-shared capability is
> used:
>
> Traceback (most recent call last):
>   File "./scripts/analyze-migration.py", line 656, in <module>
>     dump.read(dump_memory = args.memory)
>   File "./scripts/analyze-migration.py", line 593, in read
>     section.read()
>   File "./scripts/analyze-migration.py", line 163, in read
>     self.name = self.file.readstr(len = namelen)
>   File "./scripts/analyze-migration.py", line 53, in readstr
>     return self.readvar(len).decode('utf-8')
> UnicodeDecodeError: 'utf-8' codec can't decode byte 0x82 in position 55: invalid start byte
>
> We're currently adding data to the middle of the ram section depending
> on the presence of the capability. As a consequence, any code loading
> the ram section needs to know about capabilities so it can interpret
> the stream.
>
> Skip the byte that's added when x-ignore-shared is used to fix the
> script.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

> @@ -582,6 +586,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
>                  config_desc = self.vmsd_desc.get('configuration')
>                  section = ConfigurationSection(file, config_desc)
>                  section.read()
> +                ramargs['ignore_shared'] = section.has_capability('x-ignore-shared')

should we consider s/x-ignore-shared/ignore-shared/?

>              elif section_type == self.QEMU_VM_SECTION_START or section_type == self.QEMU_VM_SECTION_FULL:
>                  section_id = file.read32()
>                  name = file.readstr()


