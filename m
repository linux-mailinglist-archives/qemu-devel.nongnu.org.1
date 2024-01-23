Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8EE83918A
	for <lists+qemu-devel@lfdr.de>; Tue, 23 Jan 2024 15:39:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSHuT-0002nR-Fx; Tue, 23 Jan 2024 09:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hare@suse.de>)
 id 1rSG4b-00063D-7D; Tue, 23 Jan 2024 07:40:13 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hare@suse.de>)
 id 1rSG4Y-0004rY-3Y; Tue, 23 Jan 2024 07:40:12 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48C7A21F69;
 Tue, 23 Jan 2024 12:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706013602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bsZwpBUdtm8cIYzFdHoBotXmsQ1yjRuTGaoCqNT+Zk=;
 b=o/Qnh30Xy7qnk0JukT3lYd7D7k5GaPNbD0/r3aONDg+yVtViuPPQHHAabiZEk22cXLy2IE
 lC4QlujuYY7Z7GYwggEj1X7sBuFe0Jgz/+3zkdHaaBXdJBQg6kMbzSQQEdaBIqjUd2AN8x
 NVdJ72FQvwiZCz7dD3N6TTS8TaUDIOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706013602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bsZwpBUdtm8cIYzFdHoBotXmsQ1yjRuTGaoCqNT+Zk=;
 b=WutBRYZwaoiM5BrrvuI1GN7qhxl4mQyy7YoMhAH0fLCcLm3np0Eyr7/ezcriGYuQaHz4PM
 vQPffbVeO3ew/HAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706013602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bsZwpBUdtm8cIYzFdHoBotXmsQ1yjRuTGaoCqNT+Zk=;
 b=o/Qnh30Xy7qnk0JukT3lYd7D7k5GaPNbD0/r3aONDg+yVtViuPPQHHAabiZEk22cXLy2IE
 lC4QlujuYY7Z7GYwggEj1X7sBuFe0Jgz/+3zkdHaaBXdJBQg6kMbzSQQEdaBIqjUd2AN8x
 NVdJ72FQvwiZCz7dD3N6TTS8TaUDIOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706013602;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bsZwpBUdtm8cIYzFdHoBotXmsQ1yjRuTGaoCqNT+Zk=;
 b=WutBRYZwaoiM5BrrvuI1GN7qhxl4mQyy7YoMhAH0fLCcLm3np0Eyr7/ezcriGYuQaHz4PM
 vQPffbVeO3ew/HAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ECA113786;
 Tue, 23 Jan 2024 12:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z7mCCqKzr2U/QQAAD6G6ig
 (envelope-from <hare@suse.de>); Tue, 23 Jan 2024 12:40:02 +0000
Message-ID: <499096d7-1b4d-471b-9abf-5b6f72bb7990@suse.de>
Date: Tue, 23 Jan 2024 13:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NVME hotplug support ?
Content-Language: en-US
To: Damien Hedde <dhedde@kalrayinc.com>, qemu-block@nongnu.org,
 Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Titouan Huard <thuard@kalrayinc.com>
References: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <PR2P264MB0861AAF89D0B361A33710261D1742@PR2P264MB0861.FRAP264.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="o/Qnh30X";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WutBRYZw
X-Spamd-Result: default: False [-2.82 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 XM_UA_NO_VERSION(0.01)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 BAYES_HAM(-0.02)[52.41%]; MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; RCPT_COUNT_FIVE(0.00)[6];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; SUBJECT_ENDS_QUESTION(1.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 48C7A21F69
X-Spam-Score: -2.82
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=hare@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 23 Jan 2024 09:37:48 -0500
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

On 1/23/24 11:59, Damien Hedde wrote:
> Hi all,
> 
> We are currently looking into hotplugging nvme devices and it is currently not possible:
> When nvme was introduced 2 years ago, the feature was disabled.
>> commit cc6fb6bc506e6c47ed604fcb7b7413dff0b7d845
>> Author: Klaus Jensen
>> Date:   Tue Jul 6 10:48:40 2021 +0200
>>
>>     hw/nvme: mark nvme-subsys non-hotpluggable
>>     
>>     We currently lack the infrastructure to handle subsystem hotplugging, so
>>     disable it.
> 
> Do someone know what's lacking or anyone have some tips/idea of what we should develop to add the support ?
> 
Problem is that the object model is messed up. In qemu namespaces are 
attached to controllers, which in turn are children of the PCI device.
There are subsystems, but these just reference the controller.

So if you hotunplug the PCI device you detach/destroy the controller and 
detach the namespaces from the controller.
But if you hotplug the PCI device again the NVMe controller will be 
attached to the PCI device, but the namespace are still be detached.

Klaus said he was going to fix that, and I dimly remember some patches
floating around. But apparently it never went anywhere.

Fundamental problem is that the NVMe hierarchy as per spec is 
incompatible with the qemu object model; qemu requires a strict
tree model where every object has exactly _one_ parent.

Cheers,

Hannes


