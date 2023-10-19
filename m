Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB7F7CF7D3
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:00:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRgd-0008Kt-I7; Thu, 19 Oct 2023 07:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRgY-0008Kl-Hf
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:59:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRgX-0000k9-3v
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 07:59:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697716768;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=79OxlhpDYwebVjoSykBYH/PpLUSzzewznhMTb5li9IM=;
 b=KFovoOjQ+VHmK6chej76tMQvDgg8O6lpd8HUynt2zgzefvJPQ5m6tVWC2YmRwiKA7SkTfU
 of7wqr04sze00mHpCH0IgbWpK8KB/HYdygEmsKGBbV7ii5k1aJZ5vtWSy3ZW2ddOUqgFuK
 gAvJnPtEG7lKLk+A8BGa493M/YuwCzQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-jUvvBC2vMdWASxBuw98w6A-1; Thu, 19 Oct 2023 07:59:20 -0400
X-MC-Unique: jUvvBC2vMdWASxBuw98w6A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32da47641b5so3162704f8f.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 04:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697716759; x=1698321559;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79OxlhpDYwebVjoSykBYH/PpLUSzzewznhMTb5li9IM=;
 b=ZtduBeYAaEP8tnEV1B2h0K9ez4WZ9dnxASd9AmyJ2A5NPwD2NxVIK//Fc9+c5kC0CJ
 iEqxSEM+APeQ48UO+WwxI9QO/2MhMdk1pzfxJf/icIbX/nN2wEx0zHM16On7CQO7XvR9
 Nzzjny8HrZaD2ic5z9rQK5Z23u/qym6p1pMfXetRBxfv93jh5iK5QbsfZs7oHXIbPe8K
 Un8d30Y09P09+Nlpwhkyk8VZS2fwSUZCoE9dMbzj1j0tai7N3aCkDSFpqfgBFbMNJpxt
 qcy+hx3IcD71zmaENqwihW+8GCTYYFWub4aC4Rf05x76lyfzipFp1oLuQxELT9uSUol0
 0buQ==
X-Gm-Message-State: AOJu0YzkroHszCQaFDJ7Cp2vseLTAGrH0AJ7CPPDT5CcQ1NAJHu2mN7p
 jbYjTl0z5jwhYUEXp3mHPrHn05f5y1dzAMNklqijUrA2e5yAmeLwZ+VjldvNKHCX4exhLQEnput
 eoNWu1LiT2GZDhU8=
X-Received: by 2002:adf:fc91:0:b0:329:6e92:8d77 with SMTP id
 g17-20020adffc91000000b003296e928d77mr1635862wrr.51.1697716759406; 
 Thu, 19 Oct 2023 04:59:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFb6TdVsGuRB9F42LmumESsxtUtaBUxLIEbaQleAH3mL+HieBPYRBGUKngVbUE2Y66zHAj0rA==
X-Received: by 2002:adf:fc91:0:b0:329:6e92:8d77 with SMTP id
 g17-20020adffc91000000b003296e928d77mr1635843wrr.51.1697716759047; 
 Thu, 19 Oct 2023 04:59:19 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 n13-20020adffe0d000000b0031ad2f9269dsm4313336wrr.40.2023.10.19.04.59.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 04:59:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 08/12] tests/qtest/migration: Specify the geometry of
 the bootsector
In-Reply-To: <20231018192741.25885-9-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 18 Oct 2023 16:27:37 -0300")
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-9-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 13:59:18 +0200
Message-ID: <87v8b24ycp.fsf@secure.mitica>
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
> We're about to enable the x86_64 tests to run with the q35 machine,
> but that machine does not work with the program we use to dirty the
> memory for the tests.
>
> The issue is that QEMU needs to guess the geometry of the "disk" we
> give to it and the guessed geometry doesn't pass the sanity checks
> done by SeaBIOS. This causes SeaBIOS to interpret the geometry as if
> needing a translation from LBA to CHS and SeaBIOS ends up miscomputing
> the number of cylinders and aborting due to that.
>
> The reason things work with the "pc" machine is that is uses ATA
> instead of AHCI like q35 and SeaBIOS has an exception for ATA that
> ends up skipping the sanity checks and ignoring translation
> altogether.
>
> Workaround this situation by specifying a geometry in the command
> line.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


