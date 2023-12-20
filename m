Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D631081A286
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 16:30:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFyWE-0003x1-6Y; Wed, 20 Dec 2023 10:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@killthe.net>) id 1rFyW9-0003wQ-PP
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 10:29:53 -0500
Received: from mail.killthe.net ([207.126.114.3])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dave@killthe.net>) id 1rFyW8-0001o6-H3
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 10:29:53 -0500
Received: from magic (unknown [166.199.184.161])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.killthe.net (Postfix) with ESMTPSA id 4E8B212001C;
 Wed, 20 Dec 2023 10:29:47 -0500 (EST)
Date: Wed, 20 Dec 2023 09:33:00 -0600
From: Dave Blanchard <dave@killthe.net>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: Qemu resets terminal to crazy defaults
Message-Id: <20231220093300.29d1be92970eeaa29432c7df@killthe.net>
In-Reply-To: <87a5q4rj8j.fsf@suse.de>
References: <20231219132135.c4bff4807c9d7215b179f240@killthe.net>
 <87plz22d9r.fsf@suse.de>
 <CAFEAcA-RJUUZo0KYujQskkAim_qXkJxtuSb9wtgxoP0XSEtKYQ@mail.gmail.com>
 <CANCZdfqX=URh2C+upKQPF9sg9TX6oZpHfrYF6rGRNz-6SdbhLw@mail.gmail.com>
 <87a5q4rj8j.fsf@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__20_Dec_2023_09_33_00_-0600_ivQB/YnEcHGiMY3P"
Received-SPF: none client-ip=207.126.114.3; envelope-from=dave@killthe.net;
 helo=mail.killthe.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.

--Multipart=_Wed__20_Dec_2023_09_33_00_-0600_ivQB/YnEcHGiMY3P
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Once it was made clear the problem was in the BIOS, it was easy to find. I've made the attached patch, but haven't yet tested it.

--Multipart=_Wed__20_Dec_2023_09_33_00_-0600_ivQB/YnEcHGiMY3P
Content-Type: application/octet-stream;
 name="qemu-8.1.3-dont-screw-up-terminal-settings.patch"
Content-Disposition: attachment;
 filename="qemu-8.1.3-dont-screw-up-terminal-settings.patch"
Content-Transfer-Encoding: base64

LS0tIC4vcm9tcy9zZWFiaW9zL3NyYy9zZXJjb24uYy5vcmlnCTIwMjMtMTEtMjEgMTA6NDk6Mjcu
MDAwMDAwMDAwIC0wNjAwCisrKyAuL3JvbXMvc2VhYmlvcy9zcmMvc2VyY29uLmMJMjAyMy0xMi0x
OSAxNToyMjo0NC44MTgwNjczMDQgLTA2MDAKQEAgLTM0Niw5ICszNDYsNCBAQAogICAgIFNFVF9M
T1coc2VyY29uX3Jvd19sYXN0LCAwKTsKICAgICBTRVRfTE9XKHNlcmNvbl9hdHRyX2xhc3QsIDAp
OwotCi0gICAgc2VyY29uX3Rlcm1fcmVzZXQoKTsKLSAgICBzZXJjb25fdGVybV9ub19saW5ld3Jh
cCgpOwotICAgIGlmIChjbGVhcnNjcmVlbikKLSAgICAgICAgc2VyY29uX3Rlcm1fY2xlYXJfc2Ny
ZWVuKCk7CiB9CiAK

--Multipart=_Wed__20_Dec_2023_09_33_00_-0600_ivQB/YnEcHGiMY3P--

