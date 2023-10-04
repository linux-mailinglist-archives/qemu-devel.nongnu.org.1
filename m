Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E04A7B7E14
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 13:20:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnzut-0003Bz-Hd; Wed, 04 Oct 2023 07:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnzur-0003Bh-OC
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:19:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnzuq-0000iI-75
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 07:19:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696418383;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6UaQvCzdFT+yNTAridCQnkZDr4usCk1c8AQTCRsX4a4=;
 b=ha5sGdwbfNvwpn642lJlIAQQFu7PCr9C3FekyErNkzZj+5+iwuaLG3usAQQBMheUTAqJri
 i+0GuUpio8Td7BtRKDhY58NdSt3e8VUP6Al2b+fOAv2SPFdVR9iJSsICxs8h7SfbSs7QKR
 uHauogjQpHvL3OJDDuRM+lYJ0xqvvek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-SEkbQAJ1PIeGGPBhaaappw-1; Wed, 04 Oct 2023 07:19:31 -0400
X-MC-Unique: SEkbQAJ1PIeGGPBhaaappw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-327b5f2235aso1576694f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 04:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696418370; x=1697023170;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6UaQvCzdFT+yNTAridCQnkZDr4usCk1c8AQTCRsX4a4=;
 b=GfEGaCETEKyQ6Gu9l/ite4Uq/4aVI0hMQOhEgb6dRaRJiVFJJwOoMMKYwmPZCUzPqx
 kUq4Vfql7HESheybqOfTitvlyS9+f4ho+B8P20A3Jxxwm7QEwc+Ca1/gOceuJ1IEb1BM
 8mG3eW1vMtoVOsbHfxxYh5r6n7DzEbc7U7Lmu16wnvq0XMtixklQmsVT+9OG8vyzt2Gw
 1OjFwBrGDWfJuXeTGN0WsO+2YHgxEVtmdBnJYmrxraW6ypJzVOKhXawejzQuA69Taj0l
 Ftj5pMJHwNUwzo6ZFrohYE8ePsH6VF5Uyvzbn9uI18tKWIoYS/9hwi3oInl5u/tmQWlI
 Wkww==
X-Gm-Message-State: AOJu0Ywz+b96zJkSgw3jqZQwoJv6jC1Zb69Iz7V131JdvE9lYAGZ/haR
 cY0s21rwMUJDTa5ymlqjgbsNKujJ5iU2mLOJz2FS8XqKlTUKAgskUE0PPqQEDYZWLc9GeHHxIER
 1oipwY/0dssVSuMfc5LV+ZxVZIw==
X-Received: by 2002:a5d:6989:0:b0:321:f74d:ade6 with SMTP id
 g9-20020a5d6989000000b00321f74dade6mr1678026wru.40.1696418370297; 
 Wed, 04 Oct 2023 04:19:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVHfVQueTHLp5IJI7aUywVPXrI3yqtnt8lSI5CqTb7t8kgUsxCukb9s05Iywqc5WT9srOlBA==
X-Received: by 2002:a5d:6989:0:b0:321:f74d:ade6 with SMTP id
 g9-20020a5d6989000000b00321f74dade6mr1678005wru.40.1696418369840; 
 Wed, 04 Oct 2023 04:19:29 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 x7-20020a05600c21c700b004067e905f44sm1295595wmj.9.2023.10.04.04.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 04:19:29 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Unify and trace vmstate field_exists() checks
In-Reply-To: <20230906204722.514474-1-peterx@redhat.com> (Peter Xu's message
 of "Wed, 6 Sep 2023 16:47:22 -0400")
References: <20230906204722.514474-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 13:19:28 +0200
Message-ID: <877co24ou7.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> For both save/load we actually share the logic on deciding whether a field
> should exist.  Merge the checks into a helper and use it for both save and
> load.  When doing so, add documentations and reformat the code to make it
> much easier to read.
>
> The real benefit here (besides code cleanups) is we add a trace-point for
> this; this is a known spot where we can easily break migration
> compatibilities between binaries, and this trace point will be critical for
> us to identify such issues.
>
> For example, this will be handy when debugging things like:
>
> https://gitlab.com/qemu-project/qemu/-/issues/932
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


