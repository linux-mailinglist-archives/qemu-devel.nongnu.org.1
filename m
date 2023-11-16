Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C96D7EE622
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 18:49:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3gTa-0005O7-Hs; Thu, 16 Nov 2023 12:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1r3gTX-0005NM-NH; Thu, 16 Nov 2023 12:48:23 -0500
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1r3gTV-0007yI-MG; Thu, 16 Nov 2023 12:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=653MZfYRJ5FIjab9wmCavU2cYolP76Wfg+280xIN9C0=; b=lg8tn1hLJfdHxoTnNuAPbNibZp
 Arn7CYWSEYgQNsvOV2y4phSu+hnW6DMxJY6TDvlZHRk9G9fHyf630ihebvBcqX4ZTC4iIwVnySKYr
 MoeOxbkFHZfn9yETXllJmHeajP5zJIBgewZ8ZLZr6Kg6WhBEpRmEk7jbg30n4szyXdjQPDTFO25Qh
 +d+ozJOAhFlLNhgtL65sM3k2jpvfzmlSN6rOvRBE/tpdfR/yU2ZpO0eURyiKRhtTsTMyoHaVI5a6X
 bJDwXn8JcmLwlvwrr/dzTCuOlfmUE2AgSeOtUGoZkDCwFklCHMWjYJYf9XnC1GUotpaZMh/9syuGq
 vCgMwJGw==;
Received: from [192.168.12.109] (helo=zeus.local)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1r3gTJ-0045b3-NY; Thu, 16 Nov 2023 18:48:09 +0100
Received: from berto by zeus.local with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1r3gTJ-002k97-1u;
 Thu, 16 Nov 2023 18:48:09 +0100
Date: Thu, 16 Nov 2023 18:48:09 +0100
From: Alberto Garcia <berto@igalia.com>
To: qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 qemu-devel@nongnu.org
Subject: Converting images to stdout
Message-ID: <ZVZV2ZKcxoSargry@zeus.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

I haven't written here in a while :) but I have something small that I
would like to discuss.

Using qemu-img to convert an image and writing the result directly to
stdout is a question that has already been raised in the past (see
[1] for an example) and it's clear that it's generally not possible
because the images need to be seekable.

While I think that there's almost certainly no generic way to do
something like that for every combination of input and output formats,
I do think that it should be relatively easy to produce a qcow2 file
directly to stdout as long as the input file is on disk.

I'm interested in this use case, and I think that the method would be
as simple as this:

1. Decide a cluster size for the output qcow2 file.
2. Read the input file once to determine which clusters need to be
   allocated in the output file and which ones don't.
3. That infomation is enough to determine the number and contents of
   the refcount table, refcount blocks, and L1/L2 tables.
4. Write the qcow2 header + metadata + allocated data to stdout.

Since this would be qcow2-specific I would probably implement this as
a separate tool instead of adding it directly to qemu-img. This could
go to the scripts/ directory because I can imagine that such a tool
could be useful for other people.

Because this would be an external tool it would only support a qcow2
file with the default options. Other features like compression would
be out of scope.

For the same reason the input would be a raw file for simplicity,
other input files could be presented in raw format using
qemu-storage-daemon.

And that's the general idea, comments and questions are welcome.

Thanks!

Berto

[1] https://lists.nongnu.org/archive/html/qemu-discuss/2020-01/msg00014.html

