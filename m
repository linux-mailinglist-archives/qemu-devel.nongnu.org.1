Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4F77BFF35
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:27:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDhK-00051p-A6; Tue, 10 Oct 2023 10:26:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqDhH-00050D-6K
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:26:55 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqDhF-0000Vr-7C
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:26:54 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 943DC215EE;
 Tue, 10 Oct 2023 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696948009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46ZTjuKhBIwDvZqALvN90HJAplqSFDrGGkDj9iVryPs=;
 b=ii8QsLildu/rt4J9CIvbElKDh2C7IrIBam+9zFODcpovaJ3k8O6/lp4QFWbfNppPOMiSBH
 vOiBmCXWbKZ9oC07/y5rc2/999GluQhPTd+PDEyr/q2lE2ro2XaxPwsNPbuOrV/0WqtkWe
 zQu/FTsSEJgl8ogQPcO1OZmMH3mR7a0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696948009;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=46ZTjuKhBIwDvZqALvN90HJAplqSFDrGGkDj9iVryPs=;
 b=DH3/KWOEGVj/MV0F/WohFW+mQIYPduD+lpHIjgaLacz5UYi+/G1a/15l5D6knP39qefh2j
 ZmS3sw/6MCXa+9CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 252FF1348E;
 Tue, 10 Oct 2023 14:26:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BV92OChfJWVRBAAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 10 Oct 2023 14:26:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: prerna.saxena@nutanix.com, quintela@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, armbru@redhat.com,
 eblake@redhat.com, manish.mishra@nutanix.com,
 aravind.retnakaran@nutanix.com
Subject: Re: [PATCH v12 00/10] migration: Modify 'migrate' and
 'migrate-incoming' QAPI commands for migration
In-Reply-To: <87r0m2siz7.fsf@suse.de>
References: <20231009143615.86825-1-het.gala@nutanix.com>
 <87wmvvjymi.fsf@suse.de>
 <5e59637a-d6ba-46e6-9c28-cc8c16c7fa16@nutanix.com>
 <87r0m2siz7.fsf@suse.de>
Date: Tue, 10 Oct 2023 11:26:46 -0300
Message-ID: <87lecasgd5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Fabiano Rosas <farosas@suse.de> writes:

> Het Gala <het.gala@nutanix.com> writes:
>
>> On 10/10/2023 2:34 AM, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> This is v12 patchset of modified 'migrate' and 'migrate-incoming' QAPI=
 design
>>>> for upstream review.
>>>>
>>>> Would like to thank all the maintainers that actively participated in =
the v11
>>>> patchset discussion and gave insightful suggestions to improve the pat=
ches.
>>>>
>>>> Link to previous upstream community patchset links:
>>>> v1:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2022-2D12_msg04339.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DOXhp-cq93AZ1ZR=
IwKL5wXhx5-8ei7RfBdmmbU9KNDfg&e=3D=20=20
>>>> v2:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D02_msg02106.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3Dr7SYaB2fxLcEP2=
DiHslsbEyaY7ZPrXxageSBRtRZ7TA&e=3D=20=20
>>>> v3:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D02_msg02473.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DfnGhJw56ypUavn=
slnUL6JeK4OLi7xwh7TGsafaSSZvw&e=3D=20=20
>>>> v4:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D05_msg03064.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DSA4q18GEE4q3Eh=
7sy5nhQ8OZO5KM8kfapiBkSPZYDxE&e=3D=20=20
>>>> v5:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D05_msg04845.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DQRW_aAGHmTBajB=
nu1a4jcxQFZ1lf1N3RCyLgOt82Ji4&e=3D=20=20
>>>> v6:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D06_msg01251.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D7Dmgm47UdQ0h0Y=
9-XffsUW_ZdeQ-eCCVzhUkigTMKbc&e=3D=20=20
>>>> v7:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D07_msg02027.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D8a3tAfIJ-6st1t=
lYkbjsRWEv-JvEFxokXzanf0WCqzw&e=3D=20=20
>>>> v8:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D07_msg02770.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D4q_F05ZPdhWsPJ=
0fa850gHS90AsVX7MbsaIHi-3OsMI&e=3D=20=20
>>>> v9:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.or=
g_archive_html_qemu-2Ddevel_2023-2D07_msg04216.html&d=3DDwIFaQ&c=3Ds883GpUC=
OChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORPO=
MqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3D1wNhJSfSvAoadG=
06F2JKFHZ2mA4QWSgqvYpt1zRX9qw&e=3D=20=20
>>>> v10:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.o=
rg_archive_html_qemu-2Ddevel_2023-2D07_msg05022.html&d=3DDwIFaQ&c=3Ds883GpU=
COChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORP=
OMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DguEm3FuFn7jut=
T4ZB4RlgwttD4IMSBJy1MNh2zp3tYY&e=3D=20=20
>>>> v11:https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.gnu.o=
rg_archive_html_qemu-2Ddevel_2023-2D10_msg00740.html&d=3DDwIFaQ&c=3Ds883GpU=
COChKOHiocYtGcg&r=3D-qwZZzrw4EKSsq0BK7MBd3wW1WEpXmJeng3ZUT5uBCg&m=3Ds4FkORP=
OMqBTxCrkaYO6frUTsbcGM6c3K4FCdGaNAKeCIZ2GS9VaQxJGytQv0mGv&s=3DW7rbQhebtuWtT=
2ydMuG21OOkbqlh9KxMi1ZM5yZP6Ig&e=3D=20=20
>>>>
>>>> v11 -> v12 changelog:
>>>> -------------------
>>>> - Resolved double-freeing when using g_autoptr in structures that are
>>>>    nested into another.
>>>> - Overwriting of pointers to an existing allocated memory is solved at
>>>>    various places.
>>>> - Use of g_autoptr caused make check errors in non-error path while go=
ing
>>>>    out of scope inside function. Added g_steal_pointer() in the non-er=
ror
>>>>    paths wherever required.
>>> Please run make check before sending:
>>> =E2=96=B6 242/355 qcow2 181  FAIL
>>>
>>> You can also push your code to your gitlab and run a pipeline with the
>>> branch.
>>
>> I tested on my setup, and it passed all the checks.
>
> Ok, so this particular test must have been skipped. It's not possible
> that the test ran and passed since the issue is a very abrupt abort().
>

Ok, so I think what is going on is that both your system and CI don't
support postcopy_ram so this test is skipped.

> Try to run 'make check-block' and watch for the test 181. Or run from the
> build directory: ./tests/qemu-iotests/check -qcow2 181
>
> I started a gitlab pipeline with this code to rule out anything in my
> own setup. Let's see:
> https://gitlab.com/farosas/qemu/-/pipelines/1032002487
>

The issue manifested in the disable-tcg build in the qcow2 091
test. It's the same issue as 181.

There's also checkpatch issues. We have ./scripts/checkpatch.pl to help
with those. Just give it .patch files and it will tell you if
something's wrong with the patch.

