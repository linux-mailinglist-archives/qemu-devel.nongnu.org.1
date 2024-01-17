Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855A830914
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:05:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7S1-0006yF-MH; Wed, 17 Jan 2024 10:03:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1rQ7Rv-0006v8-8V; Wed, 17 Jan 2024 10:03:29 -0500
Received: from fencepost.gnu.org ([2001:470:142:3::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.thibault@gnu.org>)
 id 1rQ7Ru-0003uJ-Jf; Wed, 17 Jan 2024 10:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
 s=fencepost-gnu-org; h=In-Reply-To:MIME-Version:References:Subject:To:From:
 Date; bh=9UigDJ8wsawg2+McW5xJwGdF3Xa7fNJ06P1M9Z3T23U=; b=eAFKGDr11HPbnNvnkDq7
 LdqAVzKfeB90DeC8Qpi8PEi9/EKYkxGqvkMyvIDs1eLfM+YAw9feTXe+fE8yh2fmqSKG5lJrAR9hM
 mvSK8jSLDqoz8j4jPFFVBS3NdnkV0NtcYRblSBseXyHRzPPnRS7DY8tFaTqm6Yf0LS84UFMWX4AeD
 PfteONuDX6J20xTDKm89HFaxl5ssoBPi/mzrhJ7DmmRa9bAcKgu3q/kIhL4XP1iXDoJ/tUqfpo9qb
 K5Vt8pNvajW7WfHUkjRN3g9FiZLG2wnB2oyRZZV6MxvEC0ZrAOE3XoTt9LHdCHcEJ/xjJlhLWjB2W
 3t7fpQTWpe2D1g==;
Date: Wed, 17 Jan 2024 16:03:23 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, bug-hurd@gnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/4] Avoid multiple definitions of copy_file_range
Message-ID: <20240117150323.xn5otaf2ovg3hyp5@begin>
Mail-Followup-To: Manolo de Medici <manolodemedici@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, bug-hurd@gnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <CAHP40mkL6EzLgRvYZ2gp=dmF_5gxD-9cJBTODAb8UtjurZuBKg@mail.gmail.com>
 <37ef47fc-92a5-4ffe-9677-2bc013cfe20b@linaro.org>
 <CAHP40mkNb5EH_Js02LpENMc2CA2pj7fEJY_S1sTMNWh_3rcUEQ@mail.gmail.com>
 <20240117143306.lnycf2ijwkzycowj@begin>
 <CAHP40mkk4aRG+9PGjoW2U38WXSvd1NpvDgMet4AQASg3=H=UdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP40mkk4aRG+9PGjoW2U38WXSvd1NpvDgMet4AQASg3=H=UdA@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
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

Hello,

Manolo de Medici, le mer. 17 janv. 2024 15:47:09 +0100, a ecrit:
> ../../../block/file-posix.c:2003:14: error: conflicting types for
> 'copy_file_range'; have 'off_t(int,  off_t *, int,  off_t *, size_t,
> unsigned int)' {aka 'long long int(int,  long long int *, int,  long
> long int *, unsigned int,  unsigned int)'}
>  2003 | static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
>       |              ^~~~~~~~~~~~~~~
> In file included from /root/qemu/include/qemu/osdep.h:122,
>                  from ../../../block/file-posix.c:25:
> /usr/include/unistd.h:1142:9: note: previous declaration of
> 'copy_file_range' with type 'ssize_t(int,  __off64_t *, int,
> __off64_t *, size_t,  unsigned int)' {aka 'int(int,  long long int *,
> int,  long long int *, unsigned int,  unsigned int)'}
>  1142 | ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
>       |         ^~~~~~~~~~~~~~~
> 
> the current patch fixes this compilation error.

Yes, but by ignoring the difference :)

The prototype of copy_file_range in glibc really does say that it
returns an ssize_t, not an off_t, so that should be fixed so.

Samuel

