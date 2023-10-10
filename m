Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D40F67C0211
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 18:58:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqG37-00056n-3e; Tue, 10 Oct 2023 12:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqG34-00055f-KF; Tue, 10 Oct 2023 12:57:34 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qqG32-0006es-Ih; Tue, 10 Oct 2023 12:57:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C8F6729213;
 Tue, 10 Oct 2023 19:57:32 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id B1A502E248;
 Tue, 10 Oct 2023 19:57:28 +0300 (MSK)
Message-ID: <86c06027-87f8-47ba-8710-0769024d78f4@tls.msk.ru>
Date: Tue, 10 Oct 2023 19:57:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ide/ahci: fix legacy software reset
Content-Language: en-US
To: Niklas Cassel <nks@flawful.org>, John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Niklas Cassel <niklas.cassel@wdc.com>, qemu-stable <qemu-stable@nongnu.org>
References: <20231005100407.1136484-1-nks@flawful.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20231005100407.1136484-1-nks@flawful.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

05.10.2023 13:04, Niklas Cassel wrote:
> From: Niklas Cassel <niklas.cassel@wdc.com>
> 
> Legacy software contains a standard mechanism for generating a reset to a
> Serial ATA device - setting the SRST (software reset) bit in the Device
> Control register.
> 
> Serial ATA has a more robust mechanism called COMRESET, also referred to
> as port reset. A port reset is the preferred mechanism for error
> recovery and should be used in place of software reset.
> 
> Commit e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> improved the handling of PxCI, such that PxCI gets cleared after handling
> a non-NCQ, or NCQ command (instead of incorrectly clearing PxCI after
> receiving an arbitrary FIS).
> 
> However, simply clearing PxCI after a non-NCQ, or NCQ command, is not
> enough, we also need to clear PxCI when receiving a SRST in the Device
> Control register.
> 
> This fixes an issue for FreeBSD where the device would fail to reset.
> The problem was not noticed in Linux, because Linux uses a COMRESET
> instead of a legacy software reset by default.

I don't know neither this area of qemu nor how hardware works, but as
far as I can tell, this change fixes the reported FreeBSD ISO failure, -
it works fine before e2a5d9b3d9c3, it fails to see the connected drives
after, and it works again with this patch applied.  I can't say this is
a good testing, since obviously Niklas did the same testing locally too :)

John, can you send pullreq for this to master please?

Thank you Niklas for the good work!

/mjt

> Fixes: e2a5d9b3d9c3 ("hw/ide/ahci: simplify and document PxCI handling")
> Reported-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> ---
> Changes since v1: write the D2H FIS before clearing PxCI.
> 
>   hw/ide/ahci.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index babdd7b458..7269dabbdb 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1254,10 +1254,26 @@ static void handle_reg_h2d_fis(AHCIState *s, int port,
>           case STATE_RUN:
>               if (cmd_fis[15] & ATA_SRST) {
>                   s->dev[port].port_state = STATE_RESET;
> +                /*
> +                 * When setting SRST in the first H2D FIS in the reset sequence,
> +                 * the device does not send a D2H FIS. Host software thus has to
> +                 * set the "Clear Busy upon R_OK" bit such that PxCI (and BUSY)
> +                 * gets cleared. See AHCI 1.3.1, section 10.4.1 Software Reset.
> +                 */
> +                if (opts & AHCI_CMD_CLR_BUSY) {
> +                    ahci_clear_cmd_issue(ad, slot);
> +                }
>               }
>               break;
>           case STATE_RESET:
>               if (!(cmd_fis[15] & ATA_SRST)) {
> +                /*
> +                 * When clearing SRST in the second H2D FIS in the reset
> +                 * sequence, the device will send a D2H FIS. See SATA 3.5a Gold,
> +                 * section 11.4 Software reset protocol.
> +                 */
> +                ahci_clear_cmd_issue(ad, slot);
> +                ahci_write_fis_d2h(ad, false);
>                   ahci_reset_port(s, port);
>               }
>               break;


